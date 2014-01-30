helpers do
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      false
    end
  end

  def generate_urls(user_url)
    short = rand(1000000)
    until Url.where(short: short).empty?
      short = rand(1000000)
    end
    short
  end

  def modified_url(url)
    if url[0..3] != 'http'
      'http://' + url
    else
      url
    end
  end

  # Returns true if current_user exists, false otherwise
end