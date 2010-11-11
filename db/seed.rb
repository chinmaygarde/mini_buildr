#TaskType.create(:title => "test_unit")
#TaskType.create(:title => "code_smell")
TaskType.create(
  :title                    => "rcov",
  :directory_required       => true,
  :directory_input_message  => "Enter the location of your test/spec directory",
  :directory_multiple       => false
)
TaskType.create(
  :title => "rspec",
  :directory_required       => true,
  :directory_input_message  => "Enter the location of your spec directory",
  :directory_multiple       => false
)