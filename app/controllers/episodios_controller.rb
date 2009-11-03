class EpisodiosController < ApplicationController
  layout "geral"
  before_filter :authorize, :only => [:new, :create, :edit, :update, :destroy]

  # GET /episodios
  # GET /episodios.xml
  def index
    @episodios = Episodio.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @episodios }
    end
  end

  # GET /episodios/1
  # GET /episodios/1.xml
  def show
    @episodio = Episodio.find(params[:id])

    #For embedded forms
    @track = @episodio.tracks.build
    @quote = @episodio.quotes.build
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @episodio }
    end
  end

  # GET /episodios/new
  # GET /episodios/new.xml
  def new
    @episodio = Episodio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @episodio }
    end
  end

  # GET /episodios/1/edit
  def edit
    @episodio = Episodio.find(params[:id])
  end

  # POST /episodios
  # POST /episodios.xml
  def create
    @episodio = Episodio.new(params[:episodio])

    respond_to do |format|
      if @episodio.save
        flash[:notice] = 'Episodio was successfully created.'
        format.html { redirect_to(@episodio) }
        format.xml  { render :xml => @episodio, :status => :created, :location => @episodio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @episodio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /episodios/1
  # PUT /episodios/1.xml
  def update
    @episodio = Episodio.find(params[:id])

    respond_to do |format|
      if @episodio.update_attributes(params[:episodio])
        flash[:notice] = 'Episodio was successfully updated.'
        format.html { redirect_to(@episodio) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @episodio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /episodios/1
  # DELETE /episodios/1.xml
  def destroy
    @episodio = Episodio.find(params[:id])
    @episodio.destroy

    respond_to do |format|
      format.html { redirect_to(episodios_url) }
      format.xml  { head :ok }
    end
  end
end
