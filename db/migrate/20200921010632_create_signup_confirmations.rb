class CreateSignupConfirmations < ActiveRecord::Migration[6.0]
  def change
    create_table :signup_confirmations do |t|
      t.string :hash_code
      t.string :permalink
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :confirmation_number_1
      t.string :confirmation_number_2
      t.string :confirmation_number_3
      t.string :confirmation_number_4
      t.string :confirmation_number_5

      t.timestamps
    end
  end
end
