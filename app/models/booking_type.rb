# == Schema Information
#
# Table name: booking_types
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  cost_id    :bigint           not null
#  duration   :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BookingType < ApplicationRecord
  belongs_to :user
  belongs_to :cost

  has_many :bookings

end
