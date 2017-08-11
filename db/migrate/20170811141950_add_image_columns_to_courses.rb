class AddImageColumnsToCourses < ActiveRecord::Migration
  def change
    add_attachment :courses, :image
  end
end
