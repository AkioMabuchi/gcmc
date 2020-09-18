class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :permalink
      t.string :name
      t.string :email
      t.string :new_email
      t.boolean :is_certificated
      t.boolean :is_premium
      t.string :password_digest
      t.string :description
      t.string :url
      t.string :location
      t.datetime :birth
      t.string :twitter_uid
      t.string :twitter_url
      t.string :github_uid
      t.string :github_url

      t.timestamps
    end
  end
end
