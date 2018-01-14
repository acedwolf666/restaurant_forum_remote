class Followship < ApplicationRecord
  validates :followed_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :followed, class_name: "User"
end
