class Task
  include Mongoid::Document
  field :title
  embedded_in :project, :inverse_of => :tasks
end