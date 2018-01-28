module ApplicationHelper
  def count_friendships
    current_user.all_friends.count + current_user.inverse_pending_friends.count + current_user.pending_friends.count
  end
end
