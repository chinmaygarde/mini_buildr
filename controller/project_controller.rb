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
    @project = Project.get(identifier)
    haml :project_new
  end
  
  post '/create_or_update' do
    project = Project.get(params[:id])
    if project.nil?
      Project.create(
        :title => params[:title],
        :url => params[:url],
        :created_at => Time.now
      )
    else
      project.title = params[:title]
      project.url = params[:url]
      project.save
    end
    redirect '/projects'
  end
  
  delete '/delete/:id' do |identifier|
    Project.find(identifier).first.destroy
    redirect '/projects'
  end
end