class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :content

      t.timestamps
    end
  end
end
