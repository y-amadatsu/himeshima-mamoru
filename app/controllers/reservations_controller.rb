# frozen_string_literal: true

require 'csv'

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all.order(:id)
    respond_to do |format|
      format.html
      format.csv do
        filename = "reservations_#{Time.current.strftime('%Y%m%d%H%M%S')}.csv"
        send_data render_to_string, type: 'text/csv; charset=shift_jis', filename: filename
      end
      format.json do
        render json: @reservations.to_json(methods: :age)
      end
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show; end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit; end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:reserved_at, :reserved_time_slot, :name, :kana, :birthday_on, :phone_number,
                                        :proxy_input, :imported_at, :imported_by)
  end
end
