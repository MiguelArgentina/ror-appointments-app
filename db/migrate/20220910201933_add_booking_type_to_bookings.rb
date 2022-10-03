class AddBookingTypeToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :booking_type, null: false, foreign_key: true
  end
end
