module MngHelper
  
  def show_edit_track_link(track)
    if !current_user.nil? && track.user.id == current_user.id
      link_to image_tag("icons/pencil.png", :alt => "Alterar Música"), edit_track_path(track)
    end
  end
  
  def show_edit_quote_link(quote)
    if !current_user.nil? && quote.user.id == current_user.id
      link_to image_tag("icons/pencil.png", :alt => "Alterar Frase"), edit_quote_path(quote)
    end
  end
  
end