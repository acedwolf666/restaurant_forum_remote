class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name

  belongs_to :category, optional: true

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favored_users, through: :favorites, source: :user

  has_manhy :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favored?(user)
    self.favored_users.include?(user)
  end

end
