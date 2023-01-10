class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  before_action :find_course_id, only: %i[new create]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.course = @course
    if @booking.save
      redirect_to booking_path(@booking), notice: "Félicitations, votre réservation a bien été enregistrée !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path(@booking), notice: "Votre réservation a bien été modifiée."
    else
      redirect_to bookings_path(@booking), notice: "Modification impossible."
    end
  end

  def destroy
    if @booking.destroy
      redirect_to courses_path, notice: "Votre réservation a bien été supprimée."
    else
      redirect_to course_path(@booking.course)
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def find_course_id
    @course = Course.find(params[:course_id])
  end

  def booking_params
    params.require(:booking).permit(:date, :time, :user_id, :course_id)
  end
end
