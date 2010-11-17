require 'application'

# Setup paths
map "/" do
  run HomeController.new
end

map "/projects" do
  run ProjectController.new
end

map "/queues" do
  run Resque::Server.new
end

puts "Server Started in #{Application::ENVIRONMENT}..."