class User < ApplicationRecord
  mount_uploader :image, UserImageUploader
  validates :permalink, presence: true, uniqueness: true
  validates :name, presence: true
  validates :twitter_uid, uniqueness: true, allow_nil: true
  validates :github_uid, uniqueness: true, allow_nil: true
  has_secure_password

  def roles
    UserRole.where user_id: self.id
  end

  def invitations
    144
  end
end
