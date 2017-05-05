class CourseDatesController < ApplicationController
  def show
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id])
  end

  def charge
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id])

    customer = Stripe::Customer.create(
      :email => charge_params[:stripeEmail],
      :source  => charge_params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => (@course.cost*100).to_i,
      :description => @course.name,
      :currency    => 'gbp'
    )

    if customer and charge
      Booking.create(
        :course_date_id => @course_date.id,
        :stripe_charge_id => charge.id,
        :name => charge_params[:stripeBillingName],
        :email => charge_params[:stripeEmail],
        :address_line1 => charge_params[:stripeBillingAddressLine1],
        :postcode => charge_params[:stripeBillingAddressZip],
        :county => charge_params[:stripeBillingAddressState],
        :town => charge_params[:stripeBillingAddressCity],
        :country => charge_params[:stripeBillingAddressCountry],
        :paid => true
      )
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to course_path(@course)
  end

  private

  def charge_params
    params.permit(:stripeToken, :stripeTokenType, :stripeEmail, :stripeBillingName,
    :stripeBillingAddressCountry, :stripeBillingAddressCountryCode, :stripeBillingAddressZip, :stripeBillingAddressLine1,
    :stripeBillingAddressCity, :stripeBillingAddressState)
  end
end
