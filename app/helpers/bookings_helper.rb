module BookingsHelper
  def create_calendar_links booking
    event_attributes = {
      start_datetime: booking.start_time, # required
      end_datetime: (booking.start_time + booking.booking_type.duration.minutes),
      title: booking.booking_type.name, # required
      timezone: current_user.timezone, # required
      url: "https://eugenio.com",
      description: "Meeting with Eugenio",
      add_url_to_description: true # defaults to true
    }

    AddToCalendar::URLs.new(**event_attributes)
  end

  private
  def format_date_for_calendar date
    date.strftime("%Y,%m,%d,%H,%M,%S")
  end
end
