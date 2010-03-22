class ModerationRequestsController < ApplicationController
  # GET /moderation_requests
  # GET /moderation_requests.xml
  layout "geral"
  before_filter :authorize, :only => [:edit, :update, :destroy, :index, :show]
    
  def index
    @moderation_requests = ModerationRequest.all(:order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @moderation_requests }
    end
  end

  # POST /moderation_requests
  # POST /moderation_requests.xml
  def create
    @moderation_request = ModerationRequest.new(params[:moderation_request])

    @moderation_request.user_id = current_user.id

    respond_to do |format|
      if @moderation_request.save
        flash[:notice] = 'Denuncia feita com sucesso'
        format.html { redirect_to :back }
        format.xml  { render :xml => @moderation_request, :status => :created, :location => @moderation_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @moderation_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /moderation_requests/1
  # DELETE /moderation_requests/1.xml
  def destroy
    @moderation_request = ModerationRequest.find(params[:id])
    @moderation_request.destroy

    respond_to do |format|
      format.html { redirect_to(moderation_requests_url) }
      format.xml  { head :ok }
    end
  end
  
  def accept
    @d = ModerationRequest.find(params[:id])
    
    tclass = Object.const_get(@d.target_type)
    target = tclass.find(@d.target_id)
    
    target.destroy
    
    @d.destroy
    
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
