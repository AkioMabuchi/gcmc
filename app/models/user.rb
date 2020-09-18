class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :permalink, presence: true, uniqueness: true
  validates :name, presence: true
  validates :twitter_uid, uniqueness: true, allow_nil: true
  validates :github_uid, uniqueness: true, allow_nil: true
  has_secure_password
end
