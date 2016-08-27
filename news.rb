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
  property :url, String, :required => false
  property :title, String, :required => false
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
