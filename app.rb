require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'

require_relative 'models/count'

class CountApp < Sinatra::Base
  set :database_file, 'config/database.yml'

  post '/count' do
    Count.create(created_at: Time.now)
    @count = Count.all.count
    message = { count: @count}
    json message
  end

  get '/count' do
    @count = Count.all.count
    message = { count: @count}
    json message
  end

end