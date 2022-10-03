require 'mercadopago'
class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  def pay
    @booking = Booking.find(params[:id])
    sdk = Mercadopago::SDK.new('TEST-8730493886441562-102901-f24bf10ddecd448cada9598198fc7f74-73311769')
    service_name = "#{@booking.booking_type.name} (#{@booking.code})"
    amount = @booking.amount.to_f
    # Crea un objeto de preferencia
    preference_data = {
      items: [
        {
          title: service_name,
          unit_price: amount,
          quantity: 1
        }
      ],
      back_urls: {
        success: url_for(@booking),
        failure: root_path,
        pending: 'https://www.tu-sitio/pendings',
      },
      auto_return: 'approved'
    }
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]

    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    @preference_id = preference['id']
    @preference = preference
    @public_key = 'TEST-94fde7e0-f023-4c71-aa99-b9908f77f094'
  end

  def webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      status 400
      return
    end

    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']

      # Fulfill the purchase...
      puts "Payment was successful"
    end

    status 200
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
