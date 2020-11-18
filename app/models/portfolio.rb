class Portfolio < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true
  mount_uploader :image, PortfolioImageUploader
end
