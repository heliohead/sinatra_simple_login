require 'bundler'
Bundler.require

require './model'

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/logout' do
  redirect '/'
end

get '/protected' do
  erb :protected
end