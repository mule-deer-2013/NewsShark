require 'lingua'
require 'pismo'
require 'pg'
require 'active_record'
require 'active_model'
require 'article_scraper.rb'
require 'channel_article_mapper.rb'
require 'article.rb'
require 'postgres_ext'

def params
  {"article_id"=>356, "database"=>{"adapter"=>"postgresql", "database"=>"d6pfhpqd4ndt8n", "username"=>"jxfxkuolpjxwux", "password"=>"AZxlUDFdpRSG1aaQgbaJ1r-Yb3", "host"=>"ec2-23-21-113-206.compute-1.amazonaws.com", "port"=>5432}}
end

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