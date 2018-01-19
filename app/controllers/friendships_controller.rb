class FriendshipsController < ApplicationController

  def create
    @friend = User.friendships.find(params[:friend_id])
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Sent request to #{@friend.name}"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end
end
