# frozen_string_literal: true

class RemoveAuthorFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :username, :string
  end
end
