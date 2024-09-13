class Micropost < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end

  default_scope -> { order(is_pinned: :desc, created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :images,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid images format" },
                      size:         { less_than: 5.megabytes,
                                      message:   "should be less than 5MB" }

  after_save :ensure_single_is_pinned_post, if: -> { is_pinned? }

  private

  def ensure_single_is_pinned_post
    user.microposts.where(is_pinned: true).where.not(id: id).update_all(is_pinned: false)
  end
end