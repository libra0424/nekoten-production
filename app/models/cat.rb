# frozen_string_literal: true

class Cat < ApplicationRecord
  belongs_to :user
  has_many :catsposts, dependent: :destroy
  has_many :posts, through: :catsposts
end
