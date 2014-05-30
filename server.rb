require 'sinatra'
require 'pry'
#require 'csv'
require 'pg'

# def db_connection
#   begin
#     connection = PG.connect(dbname: 'slacker_news')
#   yield(connection)
#   ensure
#     connection.close
#   end
# end

def find_articles
  connection = PG.connect(dbname: 'slacker_news')
  results = connection.exec('SELECT * FROM articles ORDER BY created_at DESC')
  connection.close

  results
end

def find_urls
  urls= []
  connection = PG.connect(dbname: 'slacker_news')
  results = connection.exec('SELECT url FROM articles')
  connection.close

  results.each do |result|
    result.each do |k, v|
    urls << v
    end
  end

  urls

end

def save_article(title, url, description)
  sql = "INSERT INTO articles (title, url, description, created_at) " +
    "VALUES ($1, $2, $3, NOW())"

  connection = PG.connect(dbname: 'slacker_news')
  connection.exec_params(sql, [title, url, description])
  connection.close
end

get '/articles' do
  @articles = find_articles

  erb :'/articles/index'
end

get '/articles/new' do
  @articles = find_articles

  erb :'/articles/show'
end

post '/articles' do
@errors =[]
@urls = find_urls

  if !@urls.include?(params["url"])
      save_article(params["title"],params["url"], params["description"])
      redirect '/articles'

    else
      @errors << "Site already Posted!"

      erb :'articles/show'
    end
  end


