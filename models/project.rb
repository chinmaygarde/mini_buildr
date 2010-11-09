class Project
  include Mongoid::Document
  
  field :title
  field :url
  field :created_at, :type => Date

  embeds_many :tasks, :inverse_of => :project
  
  after_save :async_clone_repo
  
  def repo_file_path
    @repo_path ||= File.expand_path(File.join(Application::ROOT, "tmp", id.to_s))
  end
  
  def async_clone_repo
    Resque.enqueue(CloneRepo, id)
  end
  
  def repo
    Grit::Repo.new(repo_file_path) if File.exists?(repo_file_path)
  end
  
  def repo_readme
    contents = ""
    if File.exists?(repo_file_path)
      Dir.new(repo_file_path).entries.each do |file|
        if File.ftype(File.join(repo_file_path, file)) != "directory" && File.basename(File.join(repo_file_path, file)).match(/readme/i).to_s.downcase == "readme"
          contents << File.read(File.basename(file)).to_s.gsub(/\n/, "<br />")
        end
      end
    end
    contents
  end
end