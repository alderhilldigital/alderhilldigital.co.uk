class AddShowFieldsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :show_interest, :boolean, :default => true
    add_column :courses, :pay_by_card, :boolean, :default => false
    add_column :courses, :pay_by_invoice, :boolean, :default => false
  end
end
