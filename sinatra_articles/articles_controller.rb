# articles_controller.rb

require 'sinatra'
require 'json'
require './article'

articles = [
  Article.new('first', 'some text', 'some longer text', Time.now),
  Article.new('second', 'other text', 'more longer text', Time.now)
]


# ================================================================================
# html ui:
# ================================================================================

# index:
get '/articles' do
  erb :index, locals: {articles: articles}
end

# new:
get '/articles/new' do
  article = Article.new 'title', 'abstract', 'body', Time.now
  erb :new, locals: {article: article} do
    erb :_form, locals: {article: article, action: :new}
  end
end

# edit:
get '/articles/:id/edit' do
  article = articles.select {|a| a.id == params[:id].to_i}.first
  erb :edit, locals: {article: article} do
    erb :_form, locals: {article: article, action: :edit}
  end
end

# delete_confirmation:
get '/articles/:id/delete_confirmation' do
  article = articles.select {|a| a.id == params[:id].to_i}.first
  erb :delete_confirmation, locals: {article: article}
end

# delete:
post '/articles/:id/delete' do
  articles.delete_if {|a| a.id == params[:id].to_i}
  redirect to("/articles")
end

# show:
get '/articles/:id' do
  article = articles.select {|a| a.id == params[:id].to_i}.first
  puts "article => #{article.to_json}"
  #article.to_json
  erb :show, locals: {article: article}
end

# create:
post '/articles' do
  article = Article.new params[:title], params[:abstract], params[:body], params[:publish_date]
  articles << article
  redirect to("/articles/#{article.id}")
end

# update:
post '/articles/:id' do
  article = articles.select {|a| a.id == params[:id].to_i}.first
  article.update params
  redirect to("/articles/#{article.id}")
end


# ================================================================================
# json api:
# ================================================================================

# index
get '/api/articles' do
  %Q/[#{articles.map {|a| a.to_json}.join(",")}]/
end

# read
get '/api/articles/:id' do
  article = articles.select {|a| a.id == params[:id].to_i}.first
  article.to_json
end

# create
post '/api/articles' do
  article = Article.new params[:title], params[:abstract], params[:body], params[:publish_date]
  articles << article
  article.to_json
end

# update
put '/api/articles/:id' do
  article = articles.select {|a| a.id == params[:id].to_i}.first
  article.update params
  article.to_json
end

# delete
delete '/api/articles/:id' do
  articles.delete_if {|a| a.id == params[:id].to_i}
  'ok'
end
