class Invoice < ActiveRecord::Base

  validates_presence_of :organisation_name, :contact_person, :address_line_1, :town, :county, :postcode, :telephone_no, :name, :email

end
