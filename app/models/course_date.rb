class CourseDate < ActiveRecord::Base
  belongs_to :course
  has_many :bookings

  scope :active, -> { where(:disabled => false) }


  def spaces_left?
    return spaces ? ((spaces - bookings.count) > 0) : nil
  end

  def spaces_left
    return spaces - bookings.count
  end
end
