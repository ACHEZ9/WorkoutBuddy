# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(id: '1', name: "Brad", email: "bpayne@brandeis.edu", password: '12345678')
User.create(id: '2', name: "Allan", email: "achesaro@brandeis.edu", password: '12345678')
User.create(id: '3', name: "Prayuth", email: "pnadu@brandeis.edu", password: '12345678')
