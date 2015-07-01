class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :name, :password, :email
  #validates_length_of [:name, :password], in: 4..20
  # validates_confirmation_of :name
  validates_uniqueness_of :name, :email

end