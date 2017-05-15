class CourseDate < ActiveRecord::Base
  belongs_to :course

  scope :active, -> { where(:disabled => false) }

end
