class User < ApplicationRecord
  mount_uploader :image, UserImageUploader
  validates :permalink, presence: true, uniqueness: {case_sensitive: true}
  validates :name, presence: true
  validates :twitter_uid, uniqueness: {case_sensitive: true}, allow_nil: true
  validates :github_uid, uniqueness: {case_sensitive: true}, allow_nil: true
  has_secure_password

  def roles
    UserRole.where user_id: self.id
  end

  def invitations
    144
  end

  def owner?
    false
  end
end
