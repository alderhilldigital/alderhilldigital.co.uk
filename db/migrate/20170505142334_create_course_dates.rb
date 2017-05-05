class CreateCourseDates < ActiveRecord::Migration
  def change
    create_table :course_dates do |t|
      t.references :course, index: true, foreign_key: true, on_delete: :cascade
      t.datetime :begins_at
      t.integer :duration

      t.timestamps null: false
    end
  end
end
