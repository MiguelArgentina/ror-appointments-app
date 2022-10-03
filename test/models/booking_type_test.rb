# == Schema Information
#
# Table name: booking_types
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  cost_id    :bigint           not null
#  duration   :integer
#  name       :string
#  free       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class BookingTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
