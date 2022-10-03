class AddUserToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :user, null: false, foreign_key: true
    add_reference :bookings, :provider, null: false, foreign_key: { to_table: :users }
  end
end
