class ProjectController < Sinatra::Base
  helpers UserHelpers
  helpers Sinatra::ContentFor
  
  get '/?' do
    @projects = Project.all
    haml :project_index
  end
  
  get '/show/:id' do |identifier|
    @project = Project.find(identifier)
    haml :project_show
  end
  
  get '/new' do
    @project = Project.new
    haml :project_new
  end
  
  get '/update/:id' do |identifier|
    @project = Project.find(identifier)
    haml :project_new
  end
  
  post '/create_or_update' do
    begin
      project = Project.find(params[:id])
    rescue
      project = Project.new
      project.created_at = Time.now
    end  
    project.title = params[:title]
    project.url = params[:url]
    project.save
    redirect '/projects'
  end
  
  delete '/delete/:id' do |identifier|
    Project.find(identifier).destroy
    redirect '/projects'
  end
  
  get '/:id/tasks/new' do |identifier|
    @project = Project.find(identifier)
    @task_types = TaskType.all
    haml :new_task
  end
  
end