class AdminController < ApplicationController
  
  layout "geral"
  before_filter :authorize
  
  def stats

    @tracks = Track.count(:group => 'DATE(created_at)')
    @quotes = Quote.count(:group => 'DATE(created_at)')
    @users = User.count(:group => 'DATE(created_at)')

    respond_to do |format|
      format.html # stats.html.erb
    end
    
  end

  def tracks
    
    respond_to do |format|
      format.html # tracks.html.erb
    end
  end

  def quotes
    
    respond_to do |format|
      format.html # quotes.html.erb
    end
  end

  def users
    
    respond_to do |format|
      format.html # users.html.erb
    end
  end

end
