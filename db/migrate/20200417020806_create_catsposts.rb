# frozen_string_literal: true

class CreateCatsposts < ActiveRecord::Migration[5.2]
  def change
    create_table :catsposts do |t|
      t.references :post, foreign_key: true
      t.references :cat, foreign_key: true

      t.timestamps
    end
  end
end
