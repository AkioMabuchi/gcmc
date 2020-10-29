class Project < ApplicationRecord
  mount_uploader :image, ProjectImageUploader

  validates :permalink, presence: true, uniqueness: {case_sensitive: true}
  validates :owner_user_id, presence: true
  validates :title, presence: true

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
