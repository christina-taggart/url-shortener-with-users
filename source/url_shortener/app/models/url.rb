class Url < ActiveRecord::Base
  before_validation :format_url
  validates :short_key, uniqueness: true
  validates :long_url, format: { with: /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/}
  validates :long_url, format: { with: /\..+/ }
  before_save :generate_short_key

  def generate_short_key
    self.short_key = Faker::Lorem.word.split('').shuffle.join + rand(100).to_s
  end

  def format_url
    if !self.long_url.match(/\Ahttp:\/\//)
      self.long_url = "http://" + self.long_url
    end
  end
end
