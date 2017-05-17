class UserMailer < ApplicationMailer

  def contact_email(params)
    @name  = params[:name]
    @email  = params[:email]
    @message  = params[:message]
    mail(to: 'alan@astirling.co.uk', subject: 'New website contact')
  end

  def interest_email(params,course_name)
    @email  = params[:email]
    @course = course_name
    mail(to: 'alan@astirling.co.uk', subject: 'New course interest')
  end

  def invoice_email(invoice,course_date_id)
    @course_date = CourseDate.find(course_date_id)
    @course = @course_date.course
    @invoice = invoice
    mail(to: 'alan@astirling.co.uk', subject: 'New invoice request')
  end

  def confirmation_email(booking,course_date)
    @course_date = course_date
    @course = @course_date.course
    @booking = booking
    mail(to: booking.email, subject: 'Alderhill Digital: booking information')
  end

end
