class FeedsController < ApplicationController
  def index
  end

  def frases
    
    @quotes = Quote.find(:all, :limit => 100, :order => 'id DESC')
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    
  end

  def musicas
    
    @tracks = Track.find(:all, :limit => 100, :order => 'id DESC')
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    
  end

  def episodios
    
    @episodios = Episodio.find(:all, :order => "numero DESC, parte DESC", :limit => 100  )
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    
  end

end
