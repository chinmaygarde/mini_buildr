class ProjectController < Sinatra::Base
  get '/?' do
    @projects = Project.all
    haml :project_index
  end
  
  post '/new' do
    
  end
end