require 'rubygems'
require 'bundler'

Bundler.setup

require 'sinatra'
require 'sinatra/base'
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite://#{File.expand_path(File.join(File.dirname(__FILE__), "db", "development.db"))}")

Sinatra::Base.set(:public, File.join(File.dirname(__FILE__), "public"))
Sinatra::Base.set(:views, File.join(File.dirname(__FILE__), "view"))

# Require all controllers
Dir[File.dirname(__FILE__) + '/controller/*.rb'].each do |file| 
  require File.join("controller", File.basename(file, File.extname(file)))
end

# Require all models
Dir[File.dirname(__FILE__) + '/model/*.rb'].each do |file| 
  require File.join("model", File.basename(file, File.extname(file)))
end

DataMapper.auto_upgrade!

map "/projects" do
  run ProjectController.new
end