class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.all
    if params[:query].present?
      @courses = Course.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @courses = Course.all
    end
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user
    if @course.save
      redirect_to course_path(@course), notice: "Class was successfully created."
    else
      redirect_to root_path
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Class was successfully destroyed."
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to course_path(@course), notice: "Your class was successfully changed."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :user_id, :time, :category)
  end
end