class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }

  # 1. Name
  validates :name,  presence: true, length: { maximum: 50 }
  # 2. Email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # 3. Password
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  # Returns the hash digest of a given key
  # See: https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token, suitable for securing persistent session data
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given remember_token (e.g. from a cookie) matches the remember_digest
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
