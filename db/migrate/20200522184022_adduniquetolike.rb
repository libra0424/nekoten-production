# frozen_string_literal: true

class Adduniquetolike < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, %i[post_id user_id], unique: true
  end
end
