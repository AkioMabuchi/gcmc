class Project < ApplicationRecord
  mount_uploader :image, ProjectImageUploader

  validates :permalink, presence: true, uniqueness: {case_sensitive: true}
  validates :owner_user_id, presence: true
  validates :title, presence: true

  has_many :project_tags
  has_many :project_wants
  has_many :project_links

  def tags
    ProjectTag.where(project_id: self.id)
  end

  def wants
    ProjectWant.where(project_id: self.id)
  end

  def links
    ProjectLink.where(project_id: self.id)
  end

  def owner_user
    User.find_by(id: self.owner_user_id)
  end

  def accesses
    144
  end

  def likes
    1728
  end

  def comments
    567
  end

  def is_inviting
    false
  end
end
