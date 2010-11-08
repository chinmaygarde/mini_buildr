require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    Resque.stub(:enqueue)
  end
  it "should correctly set the repo path" do
    p = Factory.create(:project)
    p.repo_file_path.should == File.expand_path(File.join(Application::ROOT, "tmp", p.id))
  end
end