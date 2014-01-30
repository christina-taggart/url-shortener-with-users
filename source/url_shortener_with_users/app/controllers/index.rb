require_relative '../../config/environment'
require_relative '../../config/database'

get '/' do
  @logged_in = session[:logged_in]
  erb :index
end

post '/urls' do
  @user_url = params[:user_url]
  @short_url = generate_urls(@user_url)
  url = Url.new(short: @short_url, long: @user_url, clicks: 0)
  if url.valid?
    user_id = current_user.id if current_user
    url.update_attributes(user_id: user_id) if session[:logged_in]
    url.save
    erb :short
  else
    erb :invalid
  end
end

get '/users' do
  @users = User.all
  erb :users
end

get '/:short_url' do
  pass if params[:short_url] == "log_out"
  url = Url.where(short: params[:short_url]).first
  new_click_count = url.clicks + 1
  url.update_attributes(clicks: new_click_count)
  redirect modified_url(url.long)
end
