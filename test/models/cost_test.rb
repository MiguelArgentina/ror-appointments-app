# == Schema Information
#
# Table name: costs
#
#  id         :bigint           not null, primary key
#  start_date :datetime
#  amount     :integer
#  currency   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
require "test_helper"

class CostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
