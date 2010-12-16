class Project
  include Mongoid::Document
  
  field :title
  field :url
  field :created_at, :type => Date
  
  embeds_many :tasks
  
  after_save :async_clone_repo
  
  def repo_file_path
    @repo_path ||= File.expand_path(File.join(Application::ROOT, "tmp", id.to_s))
  end
  
  def async_clone_repo
    Resque.enqueue(CloneRepo, id)
  end
  
  def repo
    Grit::Repo.new(repo_file_path) if File.exists?(repo_file_path) && Dir.new(repo_file_path).count > 2
  end
  
  def repo_readme
    contents = ""
    if File.exists?(repo_file_path)
      Dir.new(repo_file_path).entries.each do |file|
        if File.ftype(File.join(repo_file_path, file)) != "directory" && File.basename(File.join(repo_file_path, file)).match(/readme/i).to_s.downcase == "readme"
          contents << File.read(File.expand_path(File.join(repo_file_path, file))).to_s.gsub(/\n/, "<br />")
        end
      end
    end
    contents
  end
  
  def top_level_directories
    list_files_in_dir("", false)
  end
  
  def list_files_in_dir(dir, include_non_directories=true)
    full_path = File.join(repo_file_path, dir)
    dirs = []
    if File.exists?(full_path)
      Dir.new(full_path).entries.each do |file|
        dir_check = File.ftype(File.join(full_path, file)) == "directory"
        dir_check = true if include_non_directories
        if (File.basename(file).match(/[a-zA-Z]+/).to_s != "" && file.to_s != ".git" && dir_check)
          dirs << (Pathname.new(File.expand_path(File.join(full_path, file)))).relative_path_from(Pathname.new(repo_file_path)) 
        end
      end
    end
    dirs
  end
  
  def is_dir?(file)
    File.ftype(File.join(repo_file_path, file)) == "directory"
  end
  
end