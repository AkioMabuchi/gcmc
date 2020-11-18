class AddUserPublish < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_published_twitter, :boolean
    add_column :users, :is_published_github, :boolean
  end
end
