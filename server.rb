require 'sinatra'
require 'pry'
#require 'csv'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'slacker_news')
  yield(connection)
  ensure
    connection.close
  end
end

def find_articles
  connection = PG.connect(dbname: 'slacker_news')
  results = connection.exec('SELECT * FROM articles')
  connection.close

  results
end

def save_article(title, url, description)
  sql = "INSERT INTO articles (title, url, description) " +
    "VALUES ($1, $2, $3)"

  connection = PG.connect(dbname: 'slacker_news')
  connection.exec_params(sql, [title, url, description])
  connection.close
end

get '/articles' do
  @articles = find_articles
#binding.pry
  erb :'/articles/index'
end

get '/articles/new' do
  @articles = find_articles

  erb :'/articles/show'
end

post '/articles' do
# title = params["title"]
# url = params["url"]
# description= params["description"]
 #binding.pry
 save_article(params["title"],params["url"], params["description"])

redirect '/articles'

end
