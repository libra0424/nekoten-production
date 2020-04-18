# frozen_string_literal: true

class Catspost < ApplicationRecord
  belongs_to :cat
  belongs_to :post
end
