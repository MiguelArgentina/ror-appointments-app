require 'mercadopago'
class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  def pay
    mercado_pago_access_token = Rails.application.credentials.dig(:development, :mercado_pago, :access_token)
    mercado_pago_public_key = Rails.application.credentials.dig(:development, :mercado_pago, :public_key)
    @booking = Booking.find(params[:id])
    sdk = Mercadopago::SDK.new(mercado_pago_access_token)
    service_name = "#{@booking.booking_type.name} (#{@booking.code})"
    amount = @booking.amount.to_f
    # Crea un objeto de preferencia
    preference_data = {
      items: [
        {
          title: service_name,
          unit_price: amount,
          quantity: 1,
          "currency_id": "ARS",
          "description": "Descripción del Item",
          "quantity": 1,
        }
      ],
      "payer": {
        "name": "Juan",
        "surname": "Lopez",
        "email": "user@email.com",
        "phone": {
          "area_code": "11",
          "number": "4444-4444"
        },
        "address": {
          "street_name": "Street",
          "street_number": 123,
          "zip_code": "5700"
        }
      },
      back_urls: {
        success: success_booking_url(@booking, only_path: false),
        failure: failure_booking_url(@booking, only_path: false),
        pending: pending_booking_url(@booking, only_path: false),
      },
      auto_return: 'approved'
    }
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]
    puts "#-" * 50
    puts preference
    puts "#-" * 50
    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    @preference_id = preference['id']
    if @preference_id
      @booking.update(preference_id: @preference_id)
    @preference = preference
    @public_key = mercado_pago_public_key
    else
      redirect_to booking_url(@booking), notice: 'No se pudo crear la preferencia de pago'
    end
  end

  def success
    puts "#" * 50
    puts params
    puts "#" * 50
    @booking = Booking.find_by(preference_id: params[:preference_id])
    @booking.update(owes_payment: false)
    redirect_to booking_url(@booking), notice: 'Pago realizado con éxito'
  end

  def failure
    @booking = Booking.find_by(preference_id: params[:preference_id])
    redirect_to booking_url(@booking), notice: 'Pago rechazado'
  end
  # GET /bookings or /bookings.json
  def index
    case current_user.user_type
    when 'provider'
      @bookings = Booking.includes(:booking_type).where(provider_id: current_user.id)
    when 'client'
      @bookings = current_user.bookings.includes(:booking_type)
    end

  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    @booking = Booking.new(booking_params)
    current_amount = @booking.booking_type.cost.amount
    @booking.amount = current_amount
    current_amount == 0 ? @booking.owes_payment = false : @booking.owes_payment = true
    respond_to do |format|
      if @booking.save
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully created." }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:code, :start_time, :owes_payment, :user_id, :provider_id, :booking_type_id)
    end
end
