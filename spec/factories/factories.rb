Factory.define :project do |p|
  p.sequence :id do |n|
    "1a2#{n}3c"
  end              
  p.title           "test_project"
  p.url             "git://github.com/test/project.git"
  p.created_at      Time.now
end
