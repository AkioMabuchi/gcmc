class ProjectMember < ApplicationRecord
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :position_id, presence: true

  belongs_to :project
  belongs_to :user
  belongs_to :position

  def project
    Project.find_by(id: self.project_id)
  end

  def user
    User.find_by(id: self.user_id)
  end

  def position
    Position.find_by(id: self.position_id)
  end
end
