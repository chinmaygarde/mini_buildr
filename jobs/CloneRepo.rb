require 'fileutils'

class CloneRepo
  @queue = :clone_repo
  def self.perform(repo_id, branch="master")
    repo = Project.find(repo_id)
    if !File.exists?(File.join(Application::ROOT, "tmp"))
      Dir.mkdir("tmp")
    end
    if File.exists?(File.join(Application::ROOT, "tmp/#{repo_id}"))
      FileUtils.rm_rf("tmp/#{repo_id}")
    end
    Dir.mkdir("tmp/#{repo_id}")
    Dir.chdir(File.join(Application::ROOT, "tmp/#{repo_id}")) do
      `git clone #{repo.url} .`
    end
    
  end
end