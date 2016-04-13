class PostsController < ApplicationController

  get '/posts' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    @user = User.find(session[:user_id])
    erb :'/posts/index'
  end

  get '/posts/new' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    erb :'/posts/new'
  end

  post '/posts' do
    if params[:title] == "" || params[:content] == ""
      redirect to '/posts/new'
    end
    @post = Post.create(title:params[:title], content:params[:content])
    @post.user_id = session[:user_id]
    @post.save
    redirect to "/posts/show/#{@post.id}"
  end

  get '/posts/show/:id' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end

  get '/posts/:id/edit' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    @post = Post.find(params[:id])
    erb :'/posts/edit'
  end

  patch '/posts/show/:id' do
    @post = Post.find(params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    @post.save
    redirect to '/posts'
  end

  get '/posts/:id/delete' do
    if !User.is_logged_in?(session)
      redirect to '/login'
    end
    @post = Post.find(params[:id])
    @post.delete
    redirect to '/posts'
  end

end