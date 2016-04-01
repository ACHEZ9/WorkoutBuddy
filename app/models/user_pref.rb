class UserPref < ActiveRecord::Base
  belongs_to :sport
  belongs_to :user

  def days
    @days = ""
    @days += "Monday " if self.monday
    @days += "Tuesday " if self.tuesday
    @days += "Wednesday " if self.wednesday
    @days += "Thursday " if self.thursday
    @days += "Friday " if self.friday
    @days += "Saturday " if self.saturday
    @days += "Sunday" if self.sunday
    @days.strip!
  end

  def display_sport
    if sport.nil?
      "Any"
    else
      sport.name
    end
  end

end
