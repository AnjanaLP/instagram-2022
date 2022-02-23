class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :caption, length: { maximum: 2200 }
  validates :image, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be in jpeg or png format" },
                            size: { less_than: 30.megabytes,
                                    message:   "must be less than 30MB" }
end
