class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :course_dates
  accepts_nested_attributes_for :course_dates

  scope :qualifications, -> { where(:qualification => true) }
  scope :nonqualifications, -> { where(:qualification => false) }

end
