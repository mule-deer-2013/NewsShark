require 'lingua'
require 'pismo'
require 'models/article_scraper'
require 'pg'
require 'active_record'
require 'models/article'

p params

def setup_database
  puts "Database connection details:#{params['database'].inspect}"
  return unless params['database']
  # establish database connection
  ActiveRecord::Base.establish_connetion(params['database'])
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