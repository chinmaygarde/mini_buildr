require 'application'
require 'sinatra'
require 'sinatra/base'

Sinatra::Base.set(:public, File.join(File.dirname(__FILE__), "public"))
Sinatra::Base.set(:views, File.join(File.dirname(__FILE__), "view"))
use Rack::MethodOverride

#Setup paths
map "/projects" do
  run ProjectController.new
end

map "/queues" do
  run Resque::Server.new
end