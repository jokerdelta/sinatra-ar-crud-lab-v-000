require_relative '../../config/environment'
require'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    Post.create(name: params[:name].to_s, content: params[:content].to_s.chomp)
    @posts = Post.all
    erb :index
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

    get '/posts/:id/edit' do
      @post = Post.find(params[:id])
      erb :edit
    end

    patch '/posts/:id' do
      @post = Post.find(params[:id])
      @post.update(name: params[:name].to_s, content: params[:content].to_s)
      @post.save
      redirect "/posts/#{@post.id}", 303
    end

    delete '/posts/:id/delete' do
      @post = Post.find(params[:id])
      @post.destroy
      erb :deleted
    end


end
