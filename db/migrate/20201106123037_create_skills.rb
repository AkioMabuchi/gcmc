class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.integer :user_id
      t.string :name
      t.string :level

      t.timestamps
    end
  end
end
