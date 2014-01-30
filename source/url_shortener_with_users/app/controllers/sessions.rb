enable :sessions


post '/log_in' do
  session[:logged_in] = User.authenticate(params[:email], params[:password])
  session[:user_id] = User.where(email: params[:email]).first.id if session[:logged_in]
  erb :index
end


post '/create_account' do
  User.create(params)
  erb :index
end

get '/users/:id' do
  @user = User.find(params[:id])
  @urls = @user.urls

  current_user != false && current_user.id == params[:id].to_i ? @click_access = true : @click_access = false




  erb :urls
end

get '/log_out' do
  session[:logged_in] = false
  session[:user_id] = false
  erb :index
end





