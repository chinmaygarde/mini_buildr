class Project
  include DataMapper::Resource
  
  property :id,         Serial
  property :title,      String
  property :url,        Text
  property :created_at, DateTime
  def async_clone_repo
    Resque.enqueue(CloneRepo, id)
  end
end