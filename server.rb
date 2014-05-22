require 'sinatra'
require 'pry'
require 'csv'

def open_file(file)
  articles = []
  CSV.foreach(csv, headers: true, headers_converters:  :symbol) do |article|
    articles << article
  end
  articles
end



get '/' do
  erb :index
end

get '/articles' do
  erb :articles
end

post '/articles' do

  title = params["title"]
  url = params["url"]
  description= params["description"]


CSV.open('articles.csv', 'a') do |csv|
          csv << [title, url, description]
          end
  redirect '/'
end
