class CreateBookingTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_types do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cost, null: false, foreign_key: true
      t.integer :duration
      t.string :name

      t.timestamps
    end
  end
end
