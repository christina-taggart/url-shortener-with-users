require 'uri'

class Url < ActiveRecord::Base
  belongs_to :user
  validate :validate_url

  def validate_url
    unless self.long.match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
      errors.add(:long, "not a valid url")
    end
  end

  # Remember to create a migration!
end
