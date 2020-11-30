class Review < ApplicationRecord
  validates :comment, presence: true

  belongs_to :salon
  belongs_to :user
end
