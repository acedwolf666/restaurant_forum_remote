class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Request sent"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id])
    @friendship.destroy_all
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
