class Admin::PeopleController < AdminController
  def export
    respond_to do |format|
      format.csv { send_data Person.students_to_csv, filename: 'dashsachthieunhi.csv' }
    end
  end
end
