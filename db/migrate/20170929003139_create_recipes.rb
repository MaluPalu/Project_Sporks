class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :prep_time
      t.string :cook_time
      t.string :ease
      t.string :ingredients
      t.string :instructions
      t.string :serves
      t.string :photo

      t.belongs_to :user
      t.timestamps
    end
  end
end
