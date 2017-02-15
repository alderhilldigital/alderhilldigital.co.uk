class UserMailer < ApplicationMailer

  def contact_email(params)
    @name  = params[:name]
    mail(to: 'info@alderhilldigital.co.uk', subject: 'New website contact')
  end

end
