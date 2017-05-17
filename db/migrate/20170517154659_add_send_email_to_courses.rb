class AddSendEmailToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :send_email, :boolean, :default => false
  end
end
