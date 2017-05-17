class CourseDate < ActiveRecord::Base
  belongs_to :course
  has_many :bookings

  scope :active, -> { where(:disabled => false) }


  def spaces_left?
    return (spaces - bookings.count) > 0
  end

  def spaces_left
    return spaces - bookings.count
  end
end
