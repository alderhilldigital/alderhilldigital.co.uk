class AddDisableToCourseDates < ActiveRecord::Migration
  def change
    add_column :course_dates, :disabled, :boolean, :default => false
  end
end
