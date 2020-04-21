# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :post
  belongs_to :cat
  validates :image, presence: true
end
