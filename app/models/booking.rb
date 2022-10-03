# == Schema Information
#
# Table name: bookings
#
#  id              :bigint           not null, primary key
#  code            :string
#  start_time      :datetime
#  owes_payment    :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  booking_type_id :bigint           not null
#  user_id         :bigint           not null
#
class Booking < ApplicationRecord
  belongs_to :booking_type
  belongs_to :user
  belongs_to :provider, class_name: 'User', foreign_key: 'provider_id'
  before_save :generate_booking_type_code

  private

  def generate_booking_type_code
    loop do
      code = code_generator
      self.code = code
      break unless self.class.exists?(code: code)
    end
  end

    def code_generator
      letters = (0..9).to_a + ('A'..'Z').to_a
      "#{letters.sample(9).in_groups_of(3).map{|i| i.join}.join('-')}-#{user_id}"
    end
end
