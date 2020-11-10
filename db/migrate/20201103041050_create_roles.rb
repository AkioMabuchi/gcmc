class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.integer :sort_number
      t.string :name

      t.timestamps
    end
  end
end
