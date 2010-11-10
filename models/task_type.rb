class TaskType
  include Mongoid::Document
  
  field :title
  
  # Needs Directory Select
  field :directory_required, :type => Boolean
  field :directory_input_message
  field :directory_multiple, :type => Boolean
end