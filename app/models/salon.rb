class Salon < ApplicationRecord
  validates :name,    presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 150 }
  has_many :reviews
end
