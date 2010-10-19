class Project
  include MongoMapper::Document
  
  key :title,      String
  key :url,        String
  key :created_at, Time
  
  def async_clone_repo
    Resque.enqueue(CloneRepo, id)
  end
end