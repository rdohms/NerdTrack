namespace :nt do
  namespace :fix do
    desc "Fixes Twitter entries by re-saving users and going through before_save methods"
    task :twitter => :environment do
      @users = User.find(:all)
      @users.each do |u|
        u.save
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
      open("http://jovemnerd.ig.com.br/?feed=rss2&cat=42") do |jfeed|
        response = jfeed.read
        result = RSS::Parser.parse(response, false)
        posts = result.items
      end
      
      #Loop Episodes
      posts[0...5].each_with_index do |item, i|
        
        # Parse Title
        info = item.title.scan(/(?:Nerdcast)[\s]{1}([0-9]{1,3})([a-z]?)[^A-Za-z]*(.*)/)[0]

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