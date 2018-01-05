require 'test_helper'

class ImageTestTest < ActionDispatch::IntegrationTest
def setup
   @employee = employees(:employee)
 end

 test "picture uploading" do
   log_in_as(@employee)
   get employeeportal_path(:id => @employee.id)
   assert_template 'employees/edit'
   assert_select 'input[type="file"]'
   picture = fixture_file_upload('test/fixtures/rails.png', 'picture/png')
   patch employeeportal_path(:id => @employee.id), params: {employee: { picture: picture }}
   assert @employee.picture.blank?
 end
end
