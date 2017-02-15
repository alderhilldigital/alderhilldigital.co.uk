class UserMailer < ApplicationMailer

  def contact_email(params)
    @name  = params[:name]
    @email  = params[:email]
    @message  = params[:message]
    mail(to: 'info@astirling.co.uk', subject: 'New website contact')
  end

end
