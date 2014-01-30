class User < ActiveRecord::Base
  has_many :urls
  def self.authenticate(email, password)
    !self.where(email: email, password: password).empty?
  end
end