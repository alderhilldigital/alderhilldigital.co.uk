class AddBookableToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :bookable, :boolean, :default => false
  end
end
