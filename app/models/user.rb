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

  #ランダムに生成したトークンをremember_tokenに入れて、そこからハッシュ化してremember_digestをアップデート
  def set_remember_digest
    self.remember_token = SecureRandom.urlsafe_base64
    update_attribute(:remember_digest, BCrypt::Password.create(remember_token))
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
