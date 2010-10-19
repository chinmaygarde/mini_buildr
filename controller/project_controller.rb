class ProjectController < Sinatra::Base
  get '/?' do
    @projects = Project.all
    haml :project_index
  end
  
  get '/new' do
    @project = Project.new
    haml :project_new
  end
  
  get '/update/:id' do |identifier|
    @project = Project.find(identifier)
    haml :project_new
  end
  
  get '/build/:id' do |identifier|
    project = Project.find(identifier)
    
  end
  
  post '/create_or_update' do
    project = Project.find(params[:id])
    if project.nil?
      project = Project.create(
        :title => params[:title],
        :url => params[:url],
        :created_at => Time.now
      )
    else
      project.title = params[:title]
      project.url = params[:url]
      project.save
    end
    project.async_clone_repo
    redirect '/projects'
  end
  
  delete '/delete/:id' do |identifier|
    Project.find(identifier).destroy
    redirect '/projects'
  end
end