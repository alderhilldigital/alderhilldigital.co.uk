class AddDescriptionToCourseDate < ActiveRecord::Migration
  def change
    add_column :course_dates, :description, :text
  end
end
