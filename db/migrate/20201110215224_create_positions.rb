class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.integer :role_id
      t.integer :sort_number
      t.string :name

      t.timestamps
    end
  end
end
