class RenewProject < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :content, :description
    remove_column :projects, :is_published
    remove_column :projects, :engine_id
    remove_column :projects, :platform_id
    remove_column :projects, :genre_id
    remove_column :projects, :scale_id
    add_column :projects, :publish_code, :integer
    add_column :projects, :using_language, :string
    add_column :projects, :platform, :string
    add_column :projects, :source_tool, :string
    add_column :projects, :communication_tool, :string
    add_column :projects, :project_tool, :string
    add_column :projects, :period, :string
    add_column :projects, :frequency, :string
    add_column :projects, :location, :string
  end
end
