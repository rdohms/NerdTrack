class UsersController < ApplicationController
  before_filter :authorize, :only => [:index]
  
  # GET /episodios
  # GET /episodios.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
end