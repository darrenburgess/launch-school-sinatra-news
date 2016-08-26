require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader"
require "data_mapper"
require "pry"

DataMapper.setup(:default, "sqlite3::///data/news.db")

configure do
  enable :sessions
  set :session_secret, "asdf;lkjasdfk"
end

get "/" do
  erb :index
end
