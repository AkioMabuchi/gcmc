class Position < ApplicationRecord
  validates :role_id, presence: true
  validates :sort_number, presence: true, uniqueness: {case_sensitive: true}
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  has_many :project_wants
  has_many :user_positions
end
