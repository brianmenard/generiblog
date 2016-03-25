class UsersController < ApplicationController

  get '/' do
    erb :'/users/index'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username:params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/posts'
    end
    redirect to '/login'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to '/signup'
    end
    @user = User.create(username:params[:username], password:params[:password], email:params[:email])
    session[:user_id] = @user.id
    redirect to '/posts'
  end

end