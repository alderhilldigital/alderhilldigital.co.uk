class CoursesController < ApplicationController

  def index
    @qualifications = Course.active.qualifications
    @courses = Course.active.nonqualifications
  end

  def show
    @course = Course.active.friendly.find(params[:id])
  end

  def interest
    @course = Course.active.friendly.find(params[:id])
    UserMailer.interest_email(params.permit(:email),@course.name).deliver
    flash[:success] = 'Thank you for your interest. We will be in touch soon.'
    render :action => 'show'
  end

end
