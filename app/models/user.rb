class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name

  def admin?
    self.role == "admin"
  end

  def followed?(user)
    self.followeds.include?(user)
  end

  def friended?(user)
    self.friends.include?(user)
  end

  has_many :comments, dependent: :restrict_with_error

  has_many :restaurants, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favored_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followeds, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "followed_id"
  has_many :self_followers, through: :inverse_followships, source: :user

  has_many :friendships
  has_many :friends, through: :friendships

  mount_uploader :avatar, AvatarUploader
end
