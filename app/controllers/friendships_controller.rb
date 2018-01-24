class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id], status: "pending")
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

  def show
    @all_friends = current_user.all_friends
  end

  def accept
    @pending_friend = current_user.inverse_pending_friends.where(friend_id: params[:id])
    if @pending_friend.update(status: accept)
      flash[:notice] = "Accepted #{current_user.inverse_pending_friends.name}'s request!"
    else
      flash[:alert] = @pending_friends.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def cancel
    @friendship = current_user.friendships.where(friend_id: params[:id])
    @friendship.destroy_all
    flash[:notice] = "Canceled request!"
    redirect_back(fallback_location: root_path)
  end
end
