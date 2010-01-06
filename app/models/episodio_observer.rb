class EpisodioObserver < ActiveRecord::Observer
  include ActionController::UrlWriter
  
  def after_save(newepisodio)
    
    @episodios = Episodio.all(:order => "numero DESC, parte DESC")
    
    #Add Episodio Data to Sitemaps.xml
    builder = Builder::XmlMarkup.new(:indent=>2)
    builder.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

    builder.urlset(:xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
      @episodios.each do |episodio|
        
        if episodio.id == newepisodio.id
          episodio = newepisodio
        end
        
        builder.url { |node| node.loc("http://"+HOST+"/"+episodio.to_param); node.changefreq("daily"); }
      end
    end
  
    File.open("#{RAILS_ROOT}/public/sitemap.xml", 'w') {|f| f.write(builder.target!) }
    
  end
  
  
end


# <?xml version="1.0" encoding="UTF-8"?>

#  <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
#Add the following to the bottom of the file:
#  </urlset>
