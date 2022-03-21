class User < ApplicationRecord
  VALID_EMAIL_REGEX = URI::MailTo::EMAIL_REGEXP

  extend FriendlyId
  friendly_id :username, use: :slugged

  def should_generate_new_friendly_id?
    username_changed?
  end

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :username, presence: true, length: { maximum: 20 },
                       uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end


  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})", user_id: id).includes(:user, image_attachment: :blob)
  end
end
