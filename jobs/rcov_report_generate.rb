class RcovReportGenerate
  @queue = :rcov
  def self.perform(project_id, task_id)
    project = Project.find(project_id)
    task = project.tasks.find(task_id)
    
    Dir.chdir(project.repo_file_path) do
      `rcov #{task.directories[0]}/**/*.rb -x gems`
    end
  end
end