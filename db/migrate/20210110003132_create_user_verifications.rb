class CreateUserVerifications < ActiveRecord::Migration[6.0]
  def change
    create_table :user_verifications do |t|
      t.string :hash
      t.integer :user_id

      t.timestamps
    end
  end
end
