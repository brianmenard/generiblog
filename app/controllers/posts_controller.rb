class PostsController < ApplicationController

  get '/posts' do
    @user = User.find(session[:user_id])
    erb :'/posts/index'
  end

  get '/posts/new' do
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
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end

end