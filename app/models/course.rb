class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :course_dates
  accepts_nested_attributes_for :course_dates

  scope :active, -> { where(:disabled => false) }
  scope :qualifications, -> { where(:qualification => true) }
  scope :nonqualifications, -> { where(:qualification => false) }

  has_attached_file :image, styles: { medium: "800x800>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def spaces_left
    return course_dates.sum(:spaces_left)
  end

  def spaces_left?
    return spaces_left > 0
  end

end
