class AddBirthIsPublished < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_published_birth, :boolean
  end
end
