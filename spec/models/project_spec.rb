require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  it "should correctly set the repo path" do
    p = Factory.create(:project, :id => "123")
    p.repo_file_path.should == File.expand_path(File.join(Application::ROOT, "tmp", "123"))
  end
end