class Changesignupconfirmation < ActiveRecord::Migration[6.0]
  def change
    add_column :signup_confirmations, :encrypted_password, :string
    add_column :signup_confirmations, :encrypted_password_iv, :string
  end
end
