class AddColumnToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column(:friendships, :status, :string, :default => 0, :null=> false)
  end
end
