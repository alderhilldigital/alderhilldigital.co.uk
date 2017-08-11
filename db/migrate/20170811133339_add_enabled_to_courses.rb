class AddEnabledToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :disabled, :boolean, :default => false
  end
end
