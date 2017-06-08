class Admin::BookingsController < AdminController

  def index
    @bookings = Booking.includes(:course_date).order("course_dates.begins_at")
    @bookings = @bookings.where(:course_date_id => params[:date_form][:date]) if params[:date_form] and params[:date_form][:date] and !params[:date_form][:date].blank?
    @dates = CourseDate.all.collect{|cd| ["#{cd.course.name} #{cd.begins_at.try(:strftime, "%d/%m/%Y %H:%M")}", cd.id]}
  end

  def new
    @booking = Booking.new
    @course_dates = CourseDate.all.collect{|cd| ["#{cd.course.name}-#{cd.begins_at.try(:strftime, "%d/%m/%Y %H:%M")}", cd.id]}
  end

  def create
    @course_date = CourseDate.find(booking_params[:course_date_id])
    @course = @course_date.course
    if @course_date
      booking = Booking.create(
        :course_date_id => @course_date.id,
        :stripe_charge_id => booking_params[:stripe_charge_id],
        :name => booking_params[:name],
        :email => booking_params[:email],
        :telephone => booking_params[:telephone],
        :postcode => booking_params[:postcode],
        :paid => true
      )
      UserMailer.confirmation_email(booking,@course_date).deliver if booking and @course.send_email?
      redirect_to admin_bookings_path
    end
  end

  def new_charge
    @booking = Booking.new
    @course_dates = CourseDate.all.collect{|cd| ["#{cd.course.name}-#{cd.begins_at.try(:strftime, "%d/%m/%Y %H:%M")}", cd.id]}
  end

  def charge
    @course_date = CourseDate.find(params[:course_date_id])
    @course = @course_date.course
    #@amount = (@course.cost*100).to_i * charge_params[:quantity].to_i
    @amount = 500 * params[:quantity].to_i

    if @course_date.bookings.count < @course_date.spaces

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => @course.name,
        :currency    => 'gbp'
      )

    end
  rescue Stripe::CardError => e
    puts e.message
    flash[:error] = e.message
    redirect_to course_path(@course)
  end

  private

  def booking_params
    params.require(:booking).permit(:course_date_id,:name,:email,:telephone,:address_line1,:address_line2,:town,:county,:postcode,:paid,:country)
  end
end
