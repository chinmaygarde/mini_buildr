class Task
  include Mongoid::Document
  references_one :task_type
  embedded_in :project, :inverse_of => :tasks
end