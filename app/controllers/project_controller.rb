class ProjectController < ApplicationController
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
  
  post '/touch/:project_id' do |project_id|
    project = Project.find(project_id)
    project.save
    redirect "/projects/show/#{project.id}"
  end
  
  delete '/delete/:id' do |identifier|
    Project.find(identifier).destroy
    redirect '/projects'
  end
  
  get '/:id/tasks/new' do |identifier|
    @project = Project.find(identifier)
    @task_types = TaskType.all
    haml :new_task_select
  end
  
  post '/:id/tasks/options' do |project_id|
    @project = Project.find(project_id)
    @task_type = TaskType.find(params[:task_type_id])
    haml :new_task_options
  end
  
  post '/:id/tasks/create' do |project_id|
    project = Project.find(project_id)
    task_type = TaskType.find(params[:task_type_id])
    task = project.tasks.build
    task.task_type_id = task_type.id.to_s
    task.directories = get_directories(params, task_type)
    task.save
    redirect "/projects/show/#{project.id}"
  end
  
  get '/:project_id/tasks/:task_id/show' do |project_id, task_id|
    @project = Project.find(project_id)
    @task = @project.tasks.find(task_id)
    haml :task_show
  end
  
  delete '/:project_id/tasks/:task_id/delete' do |project_id, task_id|
    project = Project.find(project_id)
    task = project.tasks.find(task_id)
    task.delete
    redirect("/projects/show/#{project.id}")
  end
  
  get '/:project_id/tasks/:task_id/build' do |project_id, task_id|
    project = Project.find(project_id)
    task = project.tasks.find(task_id)
    Resque.enqueue(RcovReportGenerate, project.id.to_s, task.id.to_s)
    redirect("/projects/show/#{project.id}")
  end
  
  get '/:project_id/filesystem/browse/*' do |project_id, path|
    @project = Project.find(project_id)
    path = "" if path == "tree"
    if path == ""
      @back_path = nil
    else
      path_elements = path.split("/")
      path_elements = path_elements.slice(0..(path_elements.count - 2))
      path_elements = ["tree"] if path_elements.count == 1
      @back_path = path_elements.join("/")
    end
    @path = path
    @files = @project.list_files_in_dir(@path)
    haml :filesystem
  end
  
  private
  def get_directories(params, task_type)
    dirs = []
    if task_type.directory_required?
      if task_type.directory_multiple?
        params[:directory].each_value do |value|
          dirs << value
        end
      else
        dirs << params[:directory]
      end
    end
    dirs
  end
end