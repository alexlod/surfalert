class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :phone_no, :password, :password_confirmation, :surf_preferences

  has_many :surf_preferences

  validates_presence_of :email, :phone_no
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end 
