# frozen_string_literal: true

class Cat < ApplicationRecord
  belongs_to :user
  has_many :catsposts, dependent: :destroy
  has_many :posts, through: :catsposts
  mount_uploader :profile_photo, ImageUploader
  validates :name, presence: true, length: { maximum: 50 }
  validates :cat_species, length: { maximum: 50 }
  validates :coatcolor, length: { maximum: 50 }
  validate :date_before_today

  private
  def date_before_today
    errors.add(:birthday, "は今日より前の日付を選択してください") if birthday.nil? || birthday > Date.today
  end
end