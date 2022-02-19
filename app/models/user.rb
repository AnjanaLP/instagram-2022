class User < ApplicationRecord
  VALID_EMAIL_REGEX = URI::MailTo::EMAIL_REGEXP

  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :username, presence: true, length: { maximum: 50 },
                       uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
