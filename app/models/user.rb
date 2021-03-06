class User < ApplicationRecord
  has_many :tasks, dependent: :delete_all

  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, 
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :tel, presence: true, length: {maximum: 10}

  has_secure_password
  validates :password, length: {minimum: 6}, allow_nil: true
  
  # Admin deletion settings
  scope :admin_count, -> { where(admin: true).count}
  before_save :validate_admin_update
  def validate_admin_update
    if self.admin_changed?(from: true, to: false) && User.admin_count == 1
      errors.add :admin, message: i18n.t('user.admin-text.oneleft')
      throw :abort
    end
  end

  # Returns the hash digest of the given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def self.new_token
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

  # Returns true if the given token matches the digest 
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
