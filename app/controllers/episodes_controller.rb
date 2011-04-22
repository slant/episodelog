class EpisodesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:show_id]
      @show = Show.find_by_short_name(params[:show_id])
      @episodes = Episode.where(:show_id => @show.id).group_by { |e| e.season }
    end
  end

  def show    
    if params[:show_id]
      @show = Show.find_by_short_name(params[:show_id])
      @episode = Episode.where(:id => params[:id], :show_id => @show.id).first
    else
      @episode = Episode.find(params[:id])
    end
  end

  def new
    @episode = Episode.new
  end

  def edit
    @episode = Episode.find(params[:id])
  end

  def create
    @episode = Episode.new(params[:episode])

    respond_to do |format|
      if @episode.save
        format.html { redirect_to(@episode, :notice => 'Episode was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @episode = Episode.find(params[:id])

    respond_to do |format|
      if @episode.update_attributes(params[:episode])
        format.html { redirect_to(@episode, :notice => 'Episode was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @episode = Episode.find(params[:id])
    @episode.destroy

    respond_to do |format|
      format.html { redirect_to(episodes_url) }
    end
  end
end
