json.extract! booking, :id, :code, :start_time, :owes_payment, :created_at, :updated_at
json.url booking_url(booking, format: :json)
