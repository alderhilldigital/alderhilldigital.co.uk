class CoursesController < ApplicationController

  def index
    @qualifications = Course.qualifications
    @courses = Course.nonqualifications
  end

  def show
    @course = Course.friendly.find(params[:id])
  end

  def interest
    @course = Course.friendly.find(params[:id])
    UserMailer.interest_email(params.permit(:email),@course.name).deliver
    flash[:success] = 'Thank you for your interest. We will be in touch soon.'
    render :action => 'show'
  end

  

end
