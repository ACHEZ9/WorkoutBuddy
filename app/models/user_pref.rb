class UserPref < ActiveRecord::Base
  belongs_to :sport
  belongs_to :user

  def days
    @days = ""
    @days += "M " if self.monday
    @days += "Tu " if self.tuesday
    @days += "W " if self.wednesday
    @days += "Th " if self.thursday
    @days += "F " if self.friday
    @days += "Sat " if self.saturday
    @days += "Sun" if self.sunday
    @days.strip!

    return @days
  end

  def display_sport
    if sport.nil?
      "Any"
    else
      sport.name
    end
  end

end
