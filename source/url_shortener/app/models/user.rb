class User < ActiveRecord::Base
  validates :email, uniqueness: true
  before_save :encrypt_password

  def encrypt_password
    self.password = Digest::SHA256.hexdigest "#{self.password}"
  end

  def self.authenticate(email, password)
    !!User.where(email: email, password: Digest::SHA256.hexdigest(password)).first
  end
end
