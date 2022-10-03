class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.decimal :amount
      t.string :code
      t.datetime :start_time
      t.boolean :owes_payment

      t.timestamps
    end
  end
end
