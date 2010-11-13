require 'rubygems'
require 'fileutils'
require 'yaml'

require 'bundler'
Bundler.setup
Bundler.require

require 'resque/server'

module Application
  ROOT = File.dirname(__FILE__)
  ENVIRONMENT = ENV['environment'] || 'development'
  AUTH_TOKENS = YAML.load_file("config/authentications.yml")
end

# Requires
%w[helpers controllers jobs models].each do |dir|
  Dir[File.join(File.dirname(__FILE__), "app", dir, "**/*.rb")].each do |file|
    require File.expand_path(file)
  end
end

# Database
db = YAML.load_file("db/database.yml")[Application::ENVIRONMENT]
Mongoid.configure do |config|
  name = db["database"]
  host = db["host"]
  config.master = Mongo::Connection.new.db(name)
end
