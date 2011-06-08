class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(params[:friendship])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to(@friendship, :notice => 'Friendship was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      if @friendship.update_attributes(params[:friendship])
        format.html { redirect_to(@friendship, :notice => 'Friendship was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def accept_friendship
    @friendship = Friendship.find(params[:id])

    unless @friendship.accepted
      @friendship.accept(validation_code)
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to(friendships_url) }
    end
  end
end
