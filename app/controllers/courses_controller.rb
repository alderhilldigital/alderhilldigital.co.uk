class CoursesController < ApplicationController

  def index
    @qualifications = Course.qualifications
    @courses = Course.nonqualifications
  end

  def show
    @course = Course.friendly.find(params[:id])
  end

end
