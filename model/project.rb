class Project
  include DataMapper::Resource
  
  property :id,         Serial
  property :title,      String
  property :url,        Text
  property :created_at, DateTime
end