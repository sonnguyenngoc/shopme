class Admin::BookingPlanesController < ApplicationController
  before_action :set_booking_plane, only: [:show, :edit, :update, :destroy]

  # GET /booking_planes
  # GET /booking_planes.json
  def index
    authorize! :read, BookingPlane
    @booking_planes = BookingPlane.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  # GET /booking_planes/1
  # GET /booking_planes/1.json
  def show
  end

  # GET /booking_planes/new
  def new
    authorize! :create, BookingPlane
    @booking_plane = BookingPlane.new
  end

  # GET /booking_planes/1/edit
  def edit
    authorize! :update, @booking_plane
  end

  # POST /booking_planes
  # POST /booking_planes.json
  def create
    authorize! :create, BookingPlane
    @booking_plane = BookingPlane.new(booking_plane_params)

    respond_to do |format|
      if @booking_plane.save
        format.html { redirect_to @booking_plane, notice: 'Booking plane was successfully created.' }
        format.json { render :show, status: :created, location: @booking_plane }
      else
        format.html { render :new }
        format.json { render json: @booking_plane.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /booking_planes/1
  # PATCH/PUT /booking_planes/1.json
  def update
    authorize! :update, @booking_plane
    respond_to do |format|
      if @booking_plane.update(booking_plane_params)
        format.html { redirect_to @booking_plane, notice: 'Booking plane was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking_plane }
      else
        format.html { render :edit }
        format.json { render json: @booking_plane.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_planes/1
  # DELETE /booking_planes/1.json
  def destroy
    authorize! :delete, @booking_plane
    @booking_plane.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa thông tin đặt khách sạn thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking_plane
      @booking_plane = BookingPlane.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_plane_params
      params.require(:booking_plane).permit(:full_name, :email, :phone, :address, :passport, :adult, :child, :seat_number, :date_from, :date_to, :ticket_type, :address_from, :address_to, :message)
    end
end
