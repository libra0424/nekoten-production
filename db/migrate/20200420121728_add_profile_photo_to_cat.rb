# frozen_string_literal: true

class AddProfilePhotoToCat < ActiveRecord::Migration[5.2]
  def change
    add_column :cats, :profile_photo, :string
  end
end
