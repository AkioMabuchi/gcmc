class UserVerification < ApplicationRecord
  validates :hash_code, presence: true, uniqueness: {case_sensitive: true}
  validates :user_id, presence: true, uniqueness: {case_sensitive: true}

  belongs_to :user
end
