class Salon < ApplicationRecord
  validates :name,   presence: true, length: { maximum: 20 }
  validates :adress, presence: true, length: { maximum: 150 }
end
