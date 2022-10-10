# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_type              :integer          default("client")
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  pay_customer default_payment_processor: :stripe

  enum user_type: { client: 0, provider: 1, admin: 2 }

  #Associations
  has_many :booking_types
  has_many :bookings
  has_many :costs

  #Validations

  #Scopes
  scope :providers, -> { where(user_type: 1) }
end
