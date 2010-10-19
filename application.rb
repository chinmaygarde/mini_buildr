require 'rubygems'
require 'bundler'

Bundler.setup

require 'sinatra'
require 'sinatra/base'
require 'resque'
require 'resque/server'
require 'mongo_mapper'
require 'i18n'
require 'haml'

module Application
  ROOT = File.dirname(__FILE__)

  # Require all controllers
  Dir[File.dirname(__FILE__) + '/controller/*.rb'].each do |file| 
    require File.join("controller", File.basename(file, File.extname(file)))
  end

  # Require all jobs
  Dir[File.dirname(__FILE__) + '/jobs/*.rb'].each do |file| 
    require File.join("jobs", File.basename(file, File.extname(file)))
  end

  # Require all models
  Dir[File.dirname(__FILE__) + '/model/*.rb'].each do |file| 
    require File.join("model", File.basename(file, File.extname(file)))
  end
  
  MongoMapper.connection = Mongo::Connection.new('localhost')
  MongoMapper.database = 'mini_buildr'
end
