require 'sinatra'
require 'pry'
require 'csv'

def open_file(csv)
  articles = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |article|
  articles << article
  end
  articles
end



get '/' do
  @links = open_file('articles.csv')
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
