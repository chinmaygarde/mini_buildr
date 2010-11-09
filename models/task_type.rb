class TaskType
  include Mongoid::Document
  
  field :title
  referenced_in :task, :inverse_of => :task_type
end