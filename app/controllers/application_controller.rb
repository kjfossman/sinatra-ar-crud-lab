
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do 
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do 
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  post '/articles' do
    article = Article.new(params)
   
    if article.save 
      redirect "/articles/#{article.id}"
    else
      "Error"
    end
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.update(title: params[:title], content: params[:content])

    if @article.save
      redirect "/articles/#{@article.id}"
    else
      redirect "articles/#{@article.id}/edit"
    end
  end

  delete '/articles/:id' do
      @article = Article.find_by_id(params[:id])
      @article.destroy
      redirect "/articles"
  end
   
    
end
