class Deletetrheecolumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :is_certificated
    remove_column :users, :is_premium
    remove_column :users, :new_email
  end
end
