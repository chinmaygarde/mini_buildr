require 'application'
require 'resque/tasks'

require 'rake'
require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

desc "Run all specs with rcov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'gems']
end

namespace :db do
  desc "Setup database"
  task :setup => [:reset, :seed]
  
  desc "Add seed values to the database"
  task :seed do
    puts "Adding seed values"
    eval(File.read(File.join(Application::ROOT, "db", "seed.rb")))
  end
  
  desc "Clear all database values"
  task :reset do
    puts "Clearing All Data"
    Project.delete_all
    TaskType.delete_all
  end
end
