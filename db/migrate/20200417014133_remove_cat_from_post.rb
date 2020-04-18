# frozen_string_literal: true

class RemoveCatFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :posts, :cat
    remove_column :posts, :cat
  end
end
