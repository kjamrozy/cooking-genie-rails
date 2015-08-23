class User < ActiveRecord::Base
  validates :email, email: true, uniqueness: true
  validates :name, presence: true
  validates :surname, presence: true
  validates :password, length: { minimum: 8, maximum: 32 }

  has_secure_password
end
