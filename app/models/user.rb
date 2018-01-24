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

  def inverse_friended?(user)
    self.inverse_friends.include?(user)
  end

  def all_friends
    friends = self.friends + self.inverse_friends
    return friends.uniq
  end

  def accepted?(user)
    self.accepted_friends.include?(user) || self.inverse_accepted_friends.include?(user)
  end

  def pending?(user)
    self.pending_friends.include?(user)
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

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :accepted_friendships, -> {where status: 'accept'}, class_name: "Friendship"
  has_many :accepted_friends, through: :accepted_friendships, source: :friend
  has_many :inverse_accepted_friendships, -> {where status: 'accept'}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_accepted_friends, through: :inverse_accepted_friendships, source: :user

  has_many :pending_friendships, -> {where status: 'pending'}, class_name: "Friendship"
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :inverse_pending_friendships, -> {where status: 'pending'}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_pending_friends, through: :inverse_pending_friendships, source: :user

  mount_uploader :avatar, AvatarUploader
end
