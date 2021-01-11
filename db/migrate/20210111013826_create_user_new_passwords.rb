class CreateUserNewPasswords < ActiveRecord::Migration[6.0]
  def change
    create_table :user_new_passwords do |t|
      t.string :hash_code
      t.integer :user_id

      t.timestamps
    end
  end
end
