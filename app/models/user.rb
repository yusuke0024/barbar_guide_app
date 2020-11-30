class User < ApplicationRecord
  VALID_EMAIL_RAGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: VALID_EMAIL_RAGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :reviews

  enum role: { normal: 0, admin: 1, }
end
