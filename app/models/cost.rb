# == Schema Information
#
# Table name: costs
#
#  id         :bigint           not null, primary key
#  start_date :datetime
#  amount     :decimal(, )
#  currency   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
class Cost < ApplicationRecord
  enum currency: { ars: 0, usd: 1, eur: 2, gbp: 3, cad: 4, aud: 5, jpy: 6 }

  #Associations
  belongs_to :user
  has_many :booking_types
end
