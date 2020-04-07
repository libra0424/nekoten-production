class Post < ApplicationRecord

  belongs_to :user
  has_many :photo, dependent: :destroy
  accepts_nested_attributes_for :photo
end
