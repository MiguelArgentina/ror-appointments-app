module CostsHelper
  def options_for_currency
    Cost.currencies.map { |key, _value| [key.humanize, key] }
  end
end
