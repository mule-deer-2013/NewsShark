require 'lingua'
require 'pismo'
require '../../app/models/article_scraper.rb'
require 'postgres_ext'
require 'pg'
require 'active_record'
require 'activerecord-postgres-hstore'
require '../../app/models/channel_article_mapper.rb'
require '../../app/models/article.rb'

def params
  {"article_id"=>356, "database"=>{"adapter"=>"postgresql", "database"=>"d6pfhpqd4ndt8n", "username"=>"jxfxkuolpjxwux", "password"=>"AZxlUDFdpRSG1aaQgbaJ1r-Yb3", "host"=>"ec2-23-21-113-206.compute-1.amazonaws.com", "port"=>5432}}
end
p params

def setup_database
  puts "Database connection details:#{params['database'].inspect}"
  return unless params['database']
  # establish database connection
  ActiveRecord::Base.establish_connection(params['database'])
end


setup_database

def perform(article_id)
  article = Article.find(article_id)
  attributes = ArticleScraper.get_article_attributes(article.url)
  attributes.each do |attribute, value|
    article.update_attribute(attribute, value)
  end
end


perform(params['article_id'])