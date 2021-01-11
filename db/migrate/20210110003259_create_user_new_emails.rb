class CreateUserNewEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_new_emails do |t|
      t.string :hash
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
