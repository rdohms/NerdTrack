class UsersController < Clearance::UsersController
  before_filter :authorize, :only => [:index, :admintoggle]
  
  # GET /episodios
  # GET /episodios.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def admintoggle
    @user = User.find(params[:id])
    
    @user.admin = !@user.admin?
    
    respond_to do |format|
      if @user.save
        flash[:notice] = 'Status de admin alterado com sucesso.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end