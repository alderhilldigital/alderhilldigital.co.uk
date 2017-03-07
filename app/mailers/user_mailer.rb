class UserMailer < ApplicationMailer

  def contact_email(params)
    @name  = params[:name]
    @email  = params[:email]
    @message  = params[:message]
    mail(to: 'info@astirling.co.uk', subject: 'New website contact')
  end

  def interest_email(params,course_name)
    @email  = params[:email]
    @course = course_name
    mail(to: 'info@astirling.co.uk', subject: 'New course interest')
  end

end
