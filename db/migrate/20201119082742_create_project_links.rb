class CreateProjectLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :project_links do |t|
      t.integer :project_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
