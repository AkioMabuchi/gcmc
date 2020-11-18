class UserPosition < ApplicationRecord
  validates :user_id, presence: true
  validates :position_id, presence: true

  def user
    User.find_by(id: self.user_id)
  end

  def position
    Position.find_by(id: self.position_id)
  end
end
