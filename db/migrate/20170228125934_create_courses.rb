class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.boolean :qualification, :default => false
      t.string :level
      t.boolean :part_time, :default => false
      t.boolean :full_time, :default => false
      t.text :application_process
      t.text :progression
      t.text :course_content
      t.string :external_link
      t.float :cost
      t.string :duration
      t.string :qualification_no
      t.string :slug, :unique => true

      t.timestamps null: false
    end
  end
end
