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
    @inverse_friendship = current_user.inverse_friendships.where(user_id: params[:id])
    @inverse_friendship.destroy_all
    flash[:alert] = "Unfriended"
    redirect_back(fallback_location: root_path)
  end

  def show
    @all_friends = current_user.all_friends
    @all_pending_friends = current_user.pending_friends
    @all_inverse_pending_friends = current_user.inverse_pending_friends
  end

  def accept
    @pending_friend = current_user.inverse_pending_friendships.find_by(user_id: params[:id])
    @pending_friend.update_attributes(status: "accept")
    flash[:notice] = "Accepted Request!"
    #flash[:alert] = @pending_friends.errors.full_messages.to_sentence
    redirect_back(fallback_location: root_path)
  end

  def cancel
    @friendship = current_user.friendships.where(friend_id: params[:id])
    @friendship.destroy_all
    flash[:notice] = "Canceled request!"
    redirect_back(fallback_location: root_path)
  end
end
