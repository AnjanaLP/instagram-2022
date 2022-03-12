class Comment < ApplicationRecord
  belongs_to :user
  delegate :username, to: :user
  belongs_to :post

  validates :content, presence: true, length: { maximum: 2200 }
end
