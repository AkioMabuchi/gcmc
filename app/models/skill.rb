class Skill < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true
  validates :level, presence: true
end
