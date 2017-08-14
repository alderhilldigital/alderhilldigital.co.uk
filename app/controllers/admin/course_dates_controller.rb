class Admin::CourseDatesController < AdminController
  before_filter :authenticate

  def index
    @course = Course.friendly.find(params[:course_id])
    @course_dates = @course.course_dates.all.order(:begins_at)
  end

  def new
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.new(:course_id => @course.id)
  end

  def create
    @course = Course.friendly.find(params[:course_id])
    begins_at = DateTime.new course_date_params["begins_at(1i)"].to_i,
    course_date_params["begins_at(2i)"].to_i,
    course_date_params["begins_at(3i)"].to_i,
    course_date_params["begins_at(4i)"].to_i,
    course_date_params["begins_at(5i)"].to_i
    if CourseDate.create(:course_id => @course.id, :begins_at => begins_at, :duration => course_date_params[:duration], :spaces => course_date_params[:spaces])
      redirect_to admin_course_course_dates_path(@course)
    else
      render :action => 'new'
    end
  end

  def edit
    @course = Course.friendly.find(params[:course_id])
    @course_date = CourseDate.find(params[:id])
  end

  def update
    @course_date = CourseDate.find(params[:id])
    @course = @course_date.course
    begins_at = DateTime.new course_date_params["begins_at(1i)"].to_i,
    course_date_params["begins_at(2i)"].to_i,
    course_date_params["begins_at(3i)"].to_i,
    course_date_params["begins_at(4i)"].to_i,
    course_date_params["begins_at(5i)"].to_i
    if @course_date.update_attributes(course_date_params.merge(:course_id => @course.id, :begins_at => begins_at))
      redirect_to admin_course_course_dates_path(@course)
    else
      render :action => 'edit'
    end
  end

  def disable
    @course = Course.friendly.find(params[:course_id])
    @courseDate = CourseDate.find(params[:id])
    @courseDate.update_attributes(:disabled => true)
    redirect_to admin_course_course_dates_path(@course)
  end

  def enable
    @course = Course.friendly.find(params[:course_id])
    @courseDate = CourseDate.find(params[:id])
    @courseDate.update_attributes(:disabled => false)
    redirect_to admin_course_course_dates_path(@course)
  end

  def destroy
    @course = Course.friendly.find(params[:course_id])
    @courseDate = CourseDate.find(params[:id])
    @courseDate.destroy
    redirect_to admin_course_course_dates_path(@course)
  end

  private

  def course_date_params
    params.require(:course_date).permit(:course_id, :begins_at, :duration, :spaces, :description)
  end

end
