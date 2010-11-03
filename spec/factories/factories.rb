Factory.define :project do |p|
  p.id              "123abc"
  p.title           "rails"
  p.url             "git://github.com/rails/rails.git"
  p.created_at        Time.now
end
