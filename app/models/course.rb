class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :course_dates
  accepts_nested_attributes_for :course_dates

  scope :active, -> { where(:disabled => false) }
  scope :qualifications, -> { where(:qualification => true) }
  scope :nonqualifications, -> { where(:qualification => false) }

  def spaces_left
    return course_dates.sum(:spaces_left)
  end

  def spaces_left?
    return spaces_left > 0
  end

end
