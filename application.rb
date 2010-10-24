require 'rubygems'
require 'bundler'

Bundler.setup

require 'resque'
require 'resque/server'
require 'mongo_mapper'
require 'i18n'
require 'haml'
require 'grit'

module Application
  ROOT = File.dirname(__FILE__)

  # Require all controllers
  Dir[File.dirname(__FILE__) + '/controllers/*.rb'].each do |file| 
    require File.join("controllers", File.basename(file, File.extname(file)))
  end

  # Require all jobs
  Dir[File.dirname(__FILE__) + '/jobs/*.rb'].each do |file| 
    require File.join("jobs", File.basename(file, File.extname(file)))
  end

  # Require all models
  Dir[File.dirname(__FILE__) + '/models/*.rb'].each do |file| 
    require File.join("models", File.basename(file, File.extname(file)))
  end
  
  # Require all helpers
  Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each do |file| 
    require File.join("helpers", File.basename(file, File.extname(file)))
  end
  
  MongoMapper.connection = Mongo::Connection.new('localhost')
  MongoMapper.database = 'mini_buildr'
end
