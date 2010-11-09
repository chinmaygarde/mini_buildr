class ProjectController < Sinatra::Base
  helpers UserHelpers
  helpers Sinatra::ContentFor
  
  get '/?' do
    @projects = Project.all
    haml :project_index
  end
  
  get '/show/:id' do |identifier|
    @project = Project.find(:conditions => {:id => identifier}).first
    haml :project_show
  end
  
  get '/new' do
    @project = Project.new
    haml :project_new
  end
  
  get '/update/:id' do |identifier|
    @project = Project.find(:conditions => {:id => identifier}).first
    haml :project_new
  end
  
  post '/create_or_update' do
    project = Project.find(:conditions => {:id => params[:id]}).first
    if project.nil?
      project = Project.new
      project.title = params[:title]
      project.url = params[:url]
      project.created_at = Time.now
    else
      project.title = params[:title]
      project.url = params[:url]
    end
    project.save
    redirect '/projects'
  end
  
  delete '/delete/:id' do |identifier|
    Project.find(:conditions => {:id => identifier}).first.destroy
    redirect '/projects'
  end
  
  get '/:id/tasks/new' do |identifier|
    @project = Project.find(:conditions => {:id => identifier}).first
    haml :new_task
  end
  
end