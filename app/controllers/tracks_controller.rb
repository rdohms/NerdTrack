class TracksController < ApplicationController
  layout "geral"
  
  #Block other pages for now
  before_filter :authorize, :only => [:index, :show, :destroy]
  
  # GET /tracks
  # GET /tracks.xml
  def index
    @tracks = Track.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tracks }
    end
  end

  # GET /tracks/1
  # GET /tracks/1.xml
  def show
    @track = Track.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @track }
    end
  end

  # GET /tracks/new
  # GET /tracks/new.xml
  def new
    @track = Track.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @track }
    end
  end

  # GET /tracks/1/edit
  def edit
    @track = Track.find(params[:id])
    
    if current_user.nil? || current_user.id != @track.user.id
      render_unauth
    end
    
  end

  # POST /tracks
  # POST /tracks.xml
  def create
    @track = Track.new(params[:track])

    @track.user_id = current_user.id
    
    respond_to do |format|
      if @track.save
        flash[:notice] = 'Música adicionada com sucesso.'
        format.html { redirect_to :controller => "episodios", :action => 'show', :id => @track.episodio.to_param }
        format.xml  { render :xml => @track, :status => :created, :location => @track }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tracks/1
  # PUT /tracks/1.xml
  def update
    @track = Track.find(params[:id])

    if current_user.nil? || current_user.id != @track.user.id
      render_unauth
    end

    respond_to do |format|
      if @track.update_attributes(params[:track])
        flash[:notice] = 'Música alterada com sucesso.'
        format.html { redirect_to :controller => "episodios", :action => 'show', :id => @track.episodio.to_param }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.xml
  def destroy
    @track = Track.find(params[:id])
    
    if current_user.nil? || current_user.id != @track.user.id
      render_unauth
    end
    
    @track.destroy

    respond_to do |format|
      format.html { redirect_to :controller => "episodios", :action => 'show', :id => @track.episodio.to_param }
      format.xml  { head :ok }
    end
  end
end
