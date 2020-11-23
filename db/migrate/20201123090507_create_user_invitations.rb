class CreateUserInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_invitations do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :position_id
      t.integer :result_code

      t.timestamps
    end
  end
end
