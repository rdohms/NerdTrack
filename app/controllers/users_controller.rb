class UsersController < Clearance::UsersController
  before_filter :authorize, :only => [:index, :admintoggle]
  
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
  
  
  def edit
    #redirect if not logged in
    logged_in?

    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end


  def update
    #redirect if not logged in
    logged_in?

    respond_to do |format|
      if current_user.update_attributes(params[:user])
        flash[:notice] = 'Seu Perfil foi editado com sucesso!'
        format.html { redirect_to(root_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => current_user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def editpasswd
    logged_in?
    
    @user = current_user
    
  end
  
  def updatepasswd
    logged_in?
    
    respond_to do |format|
      if current_user.update_password(params[:user][:password], params[:user][:password_confirmation])
        flash[:notice] = 'Senha alterada com sucesso'
        format.html { redirect_to(root_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "editpasswd" }
        format.xml  { render :xml => current_user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def logged_in?
    if current_user.nil?
      redirect_to(root_url)
    else 
      true
    end
  end
  
  
end