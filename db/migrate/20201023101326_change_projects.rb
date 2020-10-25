class ChangeProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects,:engine
    remove_column :projects,:platform
    remove_column :projects,:genre
    remove_column :projects,:scale
    remove_column :projects,:features
    add_column :projects,:engine_id,:integer
    add_column :projects,:platform_id,:integer
    add_column :projects,:genre_id,:integer
    add_column :projects,:scale_id,:integer
  end
end
