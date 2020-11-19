class ProjectWant < ApplicationRecord
  validates :project_id, presence: true
  validates :position_id, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0, less_than: 100}

  belongs_to :project
  belongs_to :position
end
