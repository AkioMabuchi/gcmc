class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :permalink
      t.string :owner_user_id
      t.string :image
      t.string :title
      t.text :content
      t.string :engine
      t.string :platform
      t.string :genre
      t.string :scale
      t.string :features
      t.boolean :is_published

      t.timestamps
    end
  end
end
