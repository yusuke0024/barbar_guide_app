class User < ApplicationRecord
  VALID_EMAIL_RAGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: VALID_EMAIL_RAGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :reviews

  enum role: { normal: 0, admin: 1, }

  delegate :set_cookie, :delete_cookie, to: :session

  #仮想のremember_token属性を定義
  attr_accessor :remember_token

  #渡されたトークンのハッシュ値を返す(rails tutorialの分岐は現在テストで使用してないので省く)
  def self.hash_value(token)
    BCrypt::Password.create(token)
  end

  #ランダムなトークンを返す
  def self.random_token
    SecureRandom.urlsafe_base64
  end

  #ハッシュ化したトークンをremember_digestに入れる
  def set_remember_digest
    self.remember_token = User.random_token
    update_attribute(:remember_digest, User.hash_value(remember_token))
  end

  #is_password(token)で渡されたトークンとユーザーのもつremember_digestを認証
  def authenticated?(token)
    #cookieだけが残ってしまうケースに起きるバグを回避
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def delete_remember_digest
    update_attribute(:remember_digest, nil)
  end
end
