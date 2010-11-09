class TaskType
  include Mongoid::Document
  
  field :title
  #referenced_in :project
end