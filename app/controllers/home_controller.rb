class HomeController < ApplicationController

  def process_contact
    UserMailer.contact_email(params).deliver
  end

end
