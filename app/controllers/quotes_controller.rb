class QuotesController < ApplicationController
  layout "geral"
  
  #Block other pages for now
  before_filter :authorize, :only => [:index, :show]
  
  # GET /quotes
  # GET /quotes.xml
  def index
    @quotes = Quote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quotes }
    end
  end

  # GET /quotes/1
  # GET /quotes/1.xml
  def show
    @quote = Quote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quote }
    end
  end

  # GET /quotes/new
  # GET /quotes/new.xml
  def new
    @quote = Quote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quote }
    end
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
    
    only_owner(@quote)
  end

  # POST /quotes
  # POST /quotes.xml
  def create
    @quote = Quote.new(params[:quote])

    @quote.user_id = current_user.id

    respond_to do |format|
      if @quote.save
        flash[:notice] = 'Frase adicionada com sucesso!'
        format.html { redirect_to :controller => "episodios", :action => 'show', :id => @quote.episodio.to_param }
        format.xml  { render :xml => @quote, :status => :created, :location => @quote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quotes/1
  # PUT /quotes/1.xml
  def update
    @quote = Quote.find(params[:id])
    
    only_owner(@quote)

    respond_to do |format|
      if @quote.update_attributes(params[:quote])
        flash[:notice] = 'Quote was successfully updated.'
        format.html { redirect_to :controller => "episodios", :action => 'show', :id => @quote.episodio.to_param }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.xml
  def destroy
    @quote = Quote.find(params[:id])
    
    only_owner(@quote)
    
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to :controller => "episodios", :action => 'show', :id => @quote.episodio.to_param }
      format.xml  { head :ok }
    end
  end
  
  def voteup
    @quote = Quote.find(params[:id])
    
    if !current_user.nil?
        if current_user.vote_for(@quote)
           render :text => @quote.votes_for.to_s
        else
          render :json => {:op => "failure", :message => "Você já votou!"}.to_json, :status => 403
        end
    else
      render :json => {:op => "failure", :message => "É necessário estar logado para votar"}.to_json, :status => 401
    end
  end
  
  def votedown
    @quote = Quote.find(params[:id])
    
    if !current_user.nil?
      if current_user.vote_against(@quote)
         render :text => @quote.votes_against.to_s
      else
        render :json => {:op => "failure", :message => "Você já votou!"}.to_json, :status => 403
      end
    else
      render :json => {:op => "failure", :message => "É necessário estar logado para votar"}.to_json, :status => 401
    end
  end
  
  def top
    
    @quotes = Quote.tally(
      {
          :limit => 10,
          :order => "total desc"
      })
    
    respond_to do |format|
      format.html # top.html.erb
      format.xml  { render :xml => @quote }
    end
  end
end
