class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def show
    # TODO: Build a comparison between the current user and the friend
  end
end
