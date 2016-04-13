class UsersController < ApplicationController

  get '/' do
    if User.is_logged_in?(session)
      redirect to '/posts'
    end
    erb :'/users/index'
  end

  get '/login' do
    if User.is_logged_in?(session)
      redirect to '/posts'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username:params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/posts'
    end
    redirect to '/login/error'
  end

  get '/login/error' do
    erb :'/users/loginerror'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      session[:error] = "Invalid Entry"
      redirect to '/signup'
    end
    @user = User.create(username:params[:username], password:params[:password], email:params[:email])
    session[:user_id] = @user.id
    redirect to '/posts'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

    get '/:slug/posts' do
      if !User.is_logged_in?(session)
        redirect to '/login'
      end
      @user = User.find_by_slug(params[:slug])
      erb :'/users/posts'
    end

end