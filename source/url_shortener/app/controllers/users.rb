enable :sessions

get '/' do
  erb :index
end

post '/login' do
  if User.authenticate(params[:email], params[:password])
    params.delete(:password)
    session[:email] = params[:email]
    session[:name] = User.where(email: params[:email]).first.name
    redirect '/awesome_users_club'
  else
    redirect '/'
  end
end

get '/awesome_users_club' do
  p session
  if session[:email]
    erb :awesome_users_club
  else
    redirect '/'
  end
end

post '/awesome_users_club' do
  session.each { |key, value| session.delete(key) }
  p session
  redirect '/'
end
