class Admin::CoursesController < AdminController
  before_filter :authenticate

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new()
  end

  def create
    if @course = Course.create(course_params)
      redirect_to admin_courses_path
    else
      render :action => 'edit'
    end
  end

  def edit
    @course = Course.friendly.find(params[:id])
  end

  def update
    @course = Course.friendly.find(params[:id])
    if @course.update_attributes(course_params)
      redirect_to admin_courses_path
    else
      render :action => 'edit'
    end
  end

  private

  def course_params
    params.require(:course).permit(:name,:description,:qualification,:level,:part_time,:full_time,:application_process,
    :progression,:course_content,:external_link,:cost,:duration,:qualification_no,:slug)
  end
end
