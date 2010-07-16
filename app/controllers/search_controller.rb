class SearchController < ApplicationController
  
  def quotes
    
    if params[:quote]
      @results = Episodio.find(:all, :select => "episodios.*, quotes.*", :joins => "INNER JOIN quotes ON quotes.episodio_id = episodios.id", :conditions => ['quotes.quote LIKE ?', '%'+params[:quote][:term]+'%' ])
    end
    
    respond_to do |format|
      format.html # quotes.html.erb
    end
  end

end
