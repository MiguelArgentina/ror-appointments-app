class HomeController < ApplicationController
  def welcome
  end

  def dashboard
    @bookings = nil
    case current_user.user_type
    when 'provider'
      @bookings = current_user.bookings
    when 'client'
      @bookings = current_user.bookings
    end
  end
end
