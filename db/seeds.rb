require 'faker'

User.create(name: "Brad", email: "bpayne@brandeis.edu", password: '12345678')
User.create(name: "Allan", email: "achesaro@brandeis.edu", password: 'deis')
User.create(name: "Prayuth", email: "pnadu@brandeis.edu", password: '12345678')

# Users
10.times do
  name = Faker::Name.name
  email = Faker::Internet.safe_email(name)
  bio = Faker::Hipster.sentence

  User.create(name: name, email: email, password: "deis", bio: bio)
end

#Sports
%w[Basketball Soccer Football Baseball Climbing Frisby].each do |name|
  Sport.create(name: name)
end

#Boston zipcodes
@zipcodes = ["02453", "02108", "02201", "02284", "02113", "02114"]
# Events
20.times do
  sport = Sport.limit(1).order("RANDOM()").first
  desc = Faker::Hacker.say_something_smart
  time = Faker::Time.between(1.days.ago, Time.now, :day)
  date = Faker::Date.between(2.days.ago, 5.days.from_now)
  location = @zipcodes.sample

  Event.create(desc: desc, time: time, date: date, sport_id: sport[:id], location: location)
  #5 req/s limit on GoogleMaps API, this will hopefully allow seed file to not fail geocoding
  sleep(0.2)
end

# Users Signup for Events, every user gets 2 events
users = User.all
users.each do |user|
  #PG AND SQLITE3 SPECIFIC SYNTAX
  user.events << Event.limit(1).order("RANDOM()")
end

