class CourseDatesController < ApplicationController
  def show
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id])
    @undiscounted_emails = Booking.joins(:course_date).where(["course_dates.course_id = ?", @course.id]).pluck(:email).uniq.compact - @course_date.bookings.pluck(:email).uniq.compact
  end

  def book
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id] ? params[:id] : @course.course_dates.active.order("begins_at ASC").first)
    loop do
      @course_date_first = @course.course_dates.where(["begins_at >= ?", @course_date.begins_at]).order("begins_at ASC")[0]
      @course_date_second = @course.course_dates.where(["begins_at >= ?", @course_date.begins_at]).order("begins_at ASC")[1]
      @course_date_next = @course.course_dates.where(["begins_at >= ?", @course_date.begins_at]).order("begins_at ASC")[2]
      if @course_date_first.spaces_left? or @course_date_second.spaces_left?
        break
      else
        @course_date = @course_date_next
      end
    end
  end

  def charge
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id])
    @amount = (@course.cost*100).to_i * charge_params[:quantity].to_i
    @undiscounted_emails = Booking.joins(:course_date).where(["course_dates.course_id = ?", @course.id]).pluck(:email).uniq.compact - @course_date.bookings.pluck(:email).uniq.compact
    @amount -= 500*charge_params[:quantity].to_i if @undiscounted_emails.include?(params[:discount])

    if @course_date.bookings.count < @course_date.spaces

      customer = Stripe::Customer.create(
        :email => charge_params[:stripeEmail],
        :source  => charge_params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => @course.name,
        :currency    => 'gbp'
      )


      if customer and charge
        (1..charge_params[:quantity].to_i).each do |i|
          booking = Booking.create(
            :course_date_id => @course_date.id,
            :stripe_charge_id => charge.id,
            :name => charge.source.name,
            :email => charge_params[:stripeEmail],
            :address_line1 => charge.source[:address_line1],
            :address_line2 => charge.source[:address_line2],
            :postcode => charge.source[:address_zip],
            :county => charge.source[:address_state],
            :town => charge.source[:address_city],
            :country => charge.source[:address_country],
            :paid => true
          )
          UserMailer.confirmation_email(booking,@course_date).deliver if booking and @course.send_email?
        end
      end
    end
  rescue Stripe::CardError => e
    puts e.message
    flash[:error] = e.message
    redirect_to course_path(@course)
  end

  def invoice
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id])
    @invoice = Invoice.new()
  end

  def send_invoice
    @invoice = Invoice.new(invoice_params)
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id])
    if @invoice.valid?
      @course = Course.friendly.find(params[:course_id])
      @course_date = CourseDate.find(params[:id])
      UserMailer.invoice_email(@invoice,@course_date.id).deliver
      flash[:success] = 'Thank you for your information. We will be in touch soon.'
      render :action => 'show'
    else
      flash[:danger] = 'There was an error saving your details. Please check and ty again.'
      render :action => 'invoice'
    end
  end

  private

  def charge_params
    params.permit(:stripeToken, :stripeTokenType, :stripeEmail, :stripeBillingName,
    :stripeBillingAddressCountry, :stripeBillingAddressCountryCode, :stripeBillingAddressZip, :stripeBillingAddressLine1,
    :stripeBillingAddressCity, :stripeBillingAddressState,:quantity)
  end

  def invoice_params
    params.require(:invoice).permit(:organisation_name,:contact_person,:address_line_1,:address_line_2,:town,
    :county,:postcode,:telephone_no,:name,:email)
  end
end
