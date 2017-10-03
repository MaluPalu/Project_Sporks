class AddFridgeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fridge, :string
  end
end
