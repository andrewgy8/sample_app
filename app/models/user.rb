class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, 
                    format: {with: VALID_EMAIL_REGEX}, 
                    uniqueness: {case_sensitive: false}
  #password cannot be nil during initial user creation since the
  # "has_secure_password" already has built in catch for nil passwords
  validates :password, length: {minimum: 6}, presence: true, allow_nil: true

  has_secure_password

  #generates a remember token digest using BCrypt 
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #generates a new remember token using a 2^64 string generator
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #generates and stores the remember token in the user database
  #called fromt the sessions helper method, remember
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #accepts and checks the remember token is the same as the one saved in the database
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #Updates the remember digest to nil when the user logs out, 
  #clearing all the remember cookies
  def forget
    update_attribute(:remember_digest, nil)
    
  end

end
