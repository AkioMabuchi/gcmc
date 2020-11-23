class CreateJoinRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :join_requests do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :position_id
      t.integer :result_code

      t.timestamps
    end
  end
end
