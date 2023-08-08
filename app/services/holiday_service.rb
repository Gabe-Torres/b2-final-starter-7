require "httparty"
require "json"
require "pry"

class HolidayService

  def upcoming_holidays
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    JSON.parse(response.body).take(3)
  end
end

