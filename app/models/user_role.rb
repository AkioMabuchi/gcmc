class UserRole < ApplicationRecord
  validates :user_id, presence: true
  validates :role_id, presence: true

  def user
    User.find_by id: self.user_id
  end

  def role
    Role.find_by id: self.role_id
  end
end
