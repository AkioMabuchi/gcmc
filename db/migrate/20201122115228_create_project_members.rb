class CreateProjectMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :project_members do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :position_id

      t.timestamps
    end
  end
end
