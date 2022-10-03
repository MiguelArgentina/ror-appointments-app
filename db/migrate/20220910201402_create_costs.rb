class CreateCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :costs do |t|
      t.datetime :start_date
      t.decimal :amount
      t.integer :currency

      t.timestamps
    end
  end
end
