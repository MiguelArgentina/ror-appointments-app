# == Schema Information
#
# Table name: bookings
#
#  id              :bigint           not null, primary key
#  amount          :decimal(, )
#  code            :string
#  preference_id   :string
#  start_time      :datetime
#  owes_payment    :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  booking_type_id :bigint           not null
#  user_id         :bigint           not null
#  provider_id     :bigint           not null
#
require "test_helper"

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
