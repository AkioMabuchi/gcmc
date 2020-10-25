class Engine < ApplicationRecord
  validates :sort_number, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
