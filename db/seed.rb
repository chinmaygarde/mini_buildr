#TaskType.create(:title => "rspec")
#TaskType.create(:title => "test_unit")
#TaskType.create(:title => "code_smell")
TaskType.create(
  :title                    => "rcov",
  :directory_required       => true,
  :directory_input_message  => "Enter the location of your spec directory",
  :directory_multiple       => false
)