# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :catsposts, dependent: :destroy
  has_many :cats, :through => :catsposts
  accepts_nested_attributes_for :catsposts, allow_destroy: true
  accepts_nested_attributes_for :photos
  validates :caption,
            length: { maximum: 255}
  validates :caption_or_photo, presence: true
  
  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end

  private
   def caption_or_photo
      caption.presence or photos.presence
   end
end
