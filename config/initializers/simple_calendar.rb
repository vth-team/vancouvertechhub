class SimpleCalendar::MonthCalendar

  def day_of_the_week(day)
    # today = Time.zone.now.to_date
    day_of_the_week = Date::DAYNAMES[day.wday]
    day_of_the_week
  end

  # def current_month(day)
  #   month = day.strftime()
  #   puts day.month
  #   # month = today.strftime("%m")
  #   # month
  # end
end
