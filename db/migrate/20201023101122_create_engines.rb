class CreateEngines < ActiveRecord::Migration[6.0]
  def change
    create_table :engines do |t|
      t.integer :sort_number
      t.string :name

      t.timestamps
    end
  end
end
