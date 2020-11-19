class ProjectLink < ApplicationRecord
  validates :project_id, presence: true
  validates :name, presence: true
  validates :url, presence: true

  belongs_to :project
end
