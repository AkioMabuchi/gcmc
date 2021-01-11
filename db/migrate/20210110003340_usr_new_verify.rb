class UsrNewVerify < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_verified, :boolean
  end
end
