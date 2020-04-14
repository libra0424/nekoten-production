class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :name
      t.integer :age
      t.date :birthday
      t.string :cat_species
      t.integer :gender
      t.string :coatcolor
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
