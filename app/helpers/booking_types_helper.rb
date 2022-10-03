module BookingTypesHelper
  def options_for_costs
    current_user.costs.map { |cost| ["#{cost.amount} #{cost.currency.humanize}", cost.id] }
  end
end
