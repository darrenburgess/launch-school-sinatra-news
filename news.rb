require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader"
require "data_mapper"
require "pry"

DataMapper.setup(:default, "sqlite3:///data/news.db")

configure do
  enable :sessions
  set :session_secret, "asdf;lkjasdfk"
end

class News
  include DataMapper::Resource

  property :id, Serial, :required => false
  property :url, Text, :required => false
  property :title, Text, :required => false
  property :date, Date, :required => false
end

def initialize_database
  News.auto_upgrade!
end

initialize_database

get "/" do
  @news = News.all(:order => [:date.asc])
  erb :index
end

get "/new_article" do
  erb :new_article
end

post "/new_article" do
  article = News.new
  article.url = params["url"]
  article.title = params["title"]
  article.date = params["date"]

  article.save

  redirect "/"
end

post "/:id/destroy" do
  id = params["id"]

  article = News.get(id)
  article.destroy

  redirect "/"
end
