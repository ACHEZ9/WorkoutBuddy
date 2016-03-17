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

# Events
20.times do
  name = Faker::Team.sport
  desc = Faker::Hacker.say_something_smart
  time = Faker::Time.between(2.days.ago, 5.days.from_now, :day)
  location = Faker::Address.zip

  Event.create(name: name, desc: desc, time: time, location: location)
end

# Users Signup for Events, every user gets 2 events
users = User.all
users.each do |user|
  #PG AND SQLITE3 SPECIFIC SYNTAX
  user.events << Event.limit(1).order("RANDOM()")
end

