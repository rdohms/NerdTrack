namespace :nt do
  namespace :fix do
    desc "Fixes Twitter entries by re-saving users and going through before_save methods"
    task :twitter => :environment do
      @users = User.find(:all)
      @users.each do |u|
        u.save
      end
    end
    
    desc "Fixes Invalid usernames set before validation as in place"
    task :inv_username => :environment do
      @users = User.find(:all, :conditions => 'username NOT NULL')
      @users.each do |u|
        
        #check if username is valid
        unless u.username.match(/\A[a-zA-Z0-9_]*\Z/)
          
          origname = u.username
          
          #translate to valid
          u.username = u.username.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').gsub(/[^a-zA-Z0-9_]/, '_')
          
          puts "Invalid Username: "+origname+" => "+u.username
          
          #save
          if u.save
            #send message?
            if Notifications.deliver_username_change(u,origname)
              puts "mail - OK"
            end
          end
        end
      
      end
      

      
    end
  
    desc "Fixes contributions where it is clear that Hours were filled in with minutes"
    task :hms => :environment do
      @tracks = Track.find(:all)
      @tracks.each do |t|
        if t.time[0,2].to_i > 2 || t.time[3,2].to_i > 59
          
          report = "Track "+t.id.to_s+" - "+t.time
          parts = t.time.split(':')
          
          if parts[0].to_i > 2 && parts[2].to_s == "00"
            t.timeh = 0
            t.timem = parts[0]
            t.times = parts[1]

            if t.save
              report = report + " -> "+t.time
              report = report + " -- OK"
            else
              report = report + " -- Erro"
            end
          end
          
          if parts[1].to_i > 59
            while parts[1].to_i > 59 do
              parts[1] = parts[1].to_i - 60
              parts[0] = parts[0].to_i + 1
            end
            
            t.timeh = parts[0]
            t.timem = parts[1]
            t.times = parts[2]
            
            if t.save
              report = report + " -> "+t.time
              report = report + " -- OK"
            else
              report = report + " -- Erro"
            end
          end
          
          puts report
        end
      end
    
      @quotes = Quote.find(:all)
      @quotes.each do |t|
        if t.time[0,2].to_i > 2 || t.time[3,2].to_i > 59
          
          report = "Quote "+t.id.to_s+" - "+t.time
          parts = t.time.split(':')
          
          if parts[0].to_i > 2 && parts[2].to_s == "00"
            t.timeh = 0
            t.timem = parts[0]
            t.times = parts[1]

            if t.save
              report = report + " -> "+t.time
              report = report + " -- OK"
            else
              report = report + " -- Erro"
            end
          end
          
          if parts[1].to_i > 59
            while parts[1].to_i > 59 do
              parts[1] = parts[1].to_i - 60
              parts[0] = parts[0].to_i + 1
            end
            
            t.timeh = parts[0]
            t.timem = parts[1]
            t.times = parts[2]
            
            if t.save
              report = report + " -> "+t.time
              report = report + " -- OK"
            else
              report = report + " -- Erro"
            end
          end
          
          puts report
        end
      end
    end
  end
  
  namespace :parse do
    desc "Parses the Jovem Nerd feed for new episodes"
    task :jnfeed => :environment do
      
      require 'rss'
      require 'open-uri'

      posts = ""
      # Grab feed
      open("http://feed.nerdcast.com.br") do |jfeed|
        response = jfeed.read
        result = RSS::Parser.parse(response, false)
        posts = result.items
      end
      
      #Loop Episodes
      posts[0...100].each_with_index do |item, i|
        
        # Parse Title
        info = item.title.scan(/(?:Nerdcast)[\s]{1}([0-9]{1,3})([a-z]?)[^A-Za-z]*(.*)/)[0]
        
        if info.nil?
          puts "SKIP " + item.title
          next
        end
        
        # Check if its in DB
        if Episodio.first(:conditions => ["numero = ? AND parte = ?", info[0].to_s, info[1].to_s]).nil?
          
          # Parse Data
          #puts item.inspect
          ps = item.content_encoded.scan(/<p>(.*)<\/p>/)
          
          # Add to DB
          @episodio = Episodio.new()
          @episodio.numero = info[0]
          @episodio.parte = info[1]
          @episodio.titulo = info[2]
          @episodio.imagem = ps[0].to_s.scan(/src=\"([a-zA-Z0-9_\-\.\/\:]*)\"/).to_s
          @episodio.desc = ps[1].to_s
          @episodio.link = item.link
          
          # Save
          if @episodio.save
            puts "ADD " + info[0] + info[1] + " - " + info[2]
          else
            puts "ERROR " + info[0] + info[1] + " - " + info[2] + " => " + @episodio.errors.inspect
          end
          
        else
          puts "SKIP " + info[0] + info[1] + " - " + info[2]
        end
      end
    end
  end
end