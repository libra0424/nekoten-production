class Post < ApplicationRecord

  belongs_to :user
  has_many :photo, dependent: :destroy
end
