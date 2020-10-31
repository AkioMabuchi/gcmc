class ProjectTag < ApplicationRecord
  validates :project_id, presence: true
  validates :tag_id, presence: true

  def project
    Project.find_by(id: self.project_id)
  end

  def tag
    Tag.find_by(id: self.tag_id)
  end
end
