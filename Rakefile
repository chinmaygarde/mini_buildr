require 'application'
require 'resque/tasks'

require 'rake'
require 'spec/rake/spectask'
require 'metric_fu'

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

MetricFu::Configuration.run do |config|
  config.metrics  = [:churn, :saikuro, :flog, :flay, :reek, :roodi]
  config.graphs   = [:flog, :flay]
  config.saikuro  = { :output_directory => 'tmp/metirc_fu/saikuro', 
                      :input_directory => ['app'],
                      :cyclo => "",
                      :filter_cyclo => "0",
                      :warn_cyclo => "5",
                      :error_cyclo => "7",
                      :formater => "text" }
  config.flay     = {:dirs_to_flay => ['app'],
                      :minimum_score => 100,
                      :filetypes => ['rb'] }
  config.flog = { :dirs_to_flog => ['app'] }
  config.reek = { :dirs_to_reek => ['app'] }
  config.roodi = { :dirs_to_roodi => ['app'] }
end
