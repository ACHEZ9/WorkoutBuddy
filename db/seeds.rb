require 'faker'

#Don't attempt to create these users if they already exist
if User.find_by(email: "achesaro@brandeis.edu").nil?
  User.create(name: "Brad", email: "bpayne@brandeis.edu", password: '12345678')
  User.create(name: "Allan", email: "achesaro@brandeis.edu", password: 'deis')
  User.create(name: "Prayuth", email: "pnadu@brandeis.edu", password: '12345678')
end

# Users
if User.count < 20
  10.times do
    name = Faker::Name.name
    email = Faker::Internet.safe_email(name)
    bio = Faker::Hipster.sentence

    User.create(name: name, email: email, password: "deis", bio: bio)
  end
end

#Sports
%w[Basketball Soccer Football Hockey Baseball Climbing Frisby Tennis].each do |name|
  Sport.find_or_create_by(name: name)
end

#Boston zipcodes
@locations = ["Brandeis Univeristy, Waltham, MA", "Boston Common", "Bentley Univeristy", "Cold Spring Park, Newton, MA", "Chapels Field, Waltham, MA 02453"]
# Events
20.times do
  sport = Sport.limit(1).order("RANDOM()").first
  desc = Faker::Hacker.say_something_smart
  time = Faker::Time.between(1.days.ago, Time.now, :day)
  skill_level = rand(10)
  date = Faker::Date.between(1.days.from_now, 5.days.from_now)
  location = @locations.sample

  Event.create(desc: desc, time: time, date: date, sport_id: sport[:id], location: location, skill_level: skill_level)
  #5 req/s limit on GoogleMaps API, this will hopefully allow seed file to not fail geocoding
  sleep(0.2)
end

# Users Signup for Events, every user gets 2 events
users = User.all
users.each do |user|
  #PG AND SQLITE3 SPECIFIC SYNTAX
  event = Event.limit(1).order("RANDOM()")
  if(!user.events.include? event)
    user.events << event
  end
end
<<<<<<< HEAD
=======

#clear event older than a week(old seed data)
Event.where("date <= ?", Date.today - 7).destroy_all

>>>>>>> 9435450903cbd412f3d6d04d9a024c8098cf7351
