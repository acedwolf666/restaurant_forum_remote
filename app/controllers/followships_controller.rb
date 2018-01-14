class FollowshipsController < ApplicationController
  def create
  @followship = current_user.followships.new(followed_id: params[:followed_id])

  if @followship.save
    flash[:notice] = "Successfully followed"
    redirect_back(fallback_location: root_path)
  else
    flash[:alert] = @followship.errors.full_messages.to_sentence
    redirect_back(fallback_location: root_path)
  end
end
end
