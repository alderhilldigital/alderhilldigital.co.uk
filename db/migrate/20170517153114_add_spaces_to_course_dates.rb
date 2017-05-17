class AddSpacesToCourseDates < ActiveRecord::Migration
  def change
    add_column :course_dates, :spaces, :integer
  end
end
