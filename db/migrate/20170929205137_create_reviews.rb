class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :image
      t.string :content
      t.integer :rating

      t.belongs_to :user
      t.belongs_to :recipe

      t.timestamps
    end
  end
end
