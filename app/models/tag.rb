class Tag < ApplicationRecord
  validates :sort_number, presence: true, uniqueness: {case_sensitive: true}
  validates :name, presence: true, uniqueness: {case_sensitive: true}
end
