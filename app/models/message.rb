class Message < ApplicationRecord
  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validates :content, length: {minimum: 1, maximum: 200}

  def from_user
    User.find_by(id: self.from_user_id)
  end

  def to_user
    User.find_by(id: self.to_user_id)
  end
end
