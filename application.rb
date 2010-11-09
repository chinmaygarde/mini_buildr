require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require

module Application
  ROOT = File.dirname(__FILE__)

  %w[helpers controllers jobs models].each do |dir|
    Dir[File.dirname(__FILE__) + "/#{dir}/*.rb"].each do |file| 
      require File.join(dir, File.basename(file, File.extname(file)))
    end    
  end
  
  Mongoid.configure do |config|
    name = "mini_buildr"
    host = "localhost"
    config.master = Mongo::Connection.new.db(name)
  end
end
