class MigrationUsrChangeName < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_verifications, :hash
    remove_column :user_signup_details, :hash
    remove_column :user_new_emails, :hash

    add_column :user_verifications, :hash_code, :string
    add_column :user_signup_details, :hash_code, :string
    add_column :user_new_emails, :hash_code, :string
  end
end
