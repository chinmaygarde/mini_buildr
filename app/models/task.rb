class Task
  include Mongoid::Document
  field :directories, :type => Array
  field :task_type_id
  embedded_in :project, :inverse_of => :tasks
  
  def task_type
    TaskType.find(self.task_type_id) if !self.task_type_id.nil?
  end
end