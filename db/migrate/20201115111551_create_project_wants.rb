class CreateProjectWants < ActiveRecord::Migration[6.0]
  def change
    create_table :project_wants do |t|
      t.integer :project_id
      t.integer :position_id
      t.integer :amount

      t.timestamps
    end
  end
end
