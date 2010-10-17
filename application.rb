require 'rubygems'
require 'bundler'

Bundler.setup

require 'sinatra'
require 'sinatra/base'
require 'dm-core'
require 'dm-migrations'
require 'resque'
require 'resque/server'

module Application
  ROOT = File.dirname(__FILE__)

  DataMapper.setup(:default, "sqlite://#{File.expand_path(File.join(File.dirname(__FILE__), "db", "development.db"))}")

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

  DataMapper.auto_upgrade!  
end
