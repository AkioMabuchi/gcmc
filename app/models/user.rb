class User < ApplicationRecord
  mount_uploader :image, UserImageUploader
  validates :permalink, presence: true, uniqueness: {case_sensitive: true}
  validates :name, presence: true
  validates :twitter_uid, uniqueness: {case_sensitive: true}, allow_nil: true
  validates :github_uid, uniqueness: {case_sensitive: true}, allow_nil: true
  has_secure_password

  has_many :user_roles
  has_many :user_positions
  has_many :user_invitations

  def roles
    UserRole.where user_id: self.id
  end

  def invitations
    144
  end

  def owner?
    false
  end

  def wanted?(user)
    unless user.nil?
      positions = UserPosition.where(user_id: self.id).pluck(:position_id)
      projects = Project.where(owner_user_id: user.id).pluck(:id)
      wants = ProjectWant.where(project_id: projects).pluck(:position_id)
      wants.uniq!

      positions.each do |position|
        wants.each do |want|
          if position == want
            return true
          end
        end
      end
    end
    false
  end
end
