class ShowsController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless params[:q]
      @shows = Show.all.sort_by(&:name)
    else
      @query = params[:q]
      @shows = Show.where(['name LIKE ?', "%#{@query}%"])
    end
  end

  def show
    @show = Show.find_by_short_name(params[:id])
  end

  def new
    @show = Show.new
  end

  def edit
    @show = Show.find_by_short_name(params[:id])
  end

  def create
    @show = Show.new(params[:show])

    respond_to do |format|
      if @show.save
        format.html { redirect_to(@show, :notice => 'Show was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @show = Show.find(params[:id])

    respond_to do |format|
      if @show.update_attributes(params[:show])
        format.html { redirect_to(@show, :notice => 'Show was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy

    respond_to do |format|
      format.html { redirect_to(shows_url) }
    end
  end

  def recent
    @shows = Show.all
    render :index
  end
end
