require 'rubygems'
require 'fileutils'

require 'bundler'
Bundler.setup
Bundler.require

require 'resque/server'

module Application
  ROOT = File.dirname(__FILE__)

  %w[helpers controllers jobs models].each do |dir|
    Dir[File.join(File.dirname(__FILE__), "app", dir, "**/*.rb")].each do |file|
      require File.expand_path(file)
    end    
  end
  
  Mongoid.configure do |config|
    name = "mini_buildr"
    host = "localhost"
    config.master = Mongo::Connection.new.db(name)
  end
end
