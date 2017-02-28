class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :qualifications, -> { where(:qualification => true) }
  scope :nonqualifications, -> { where(:qualification => false) }

end
