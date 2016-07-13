# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#creates a user in the DB for users
# ! raises an exception and makes debugging eassier by avoiding silent errors
User.create!(name:  "Example User",
             email: "example2@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar", 
             admin: true)

99.times do |n|
  #iterates through 99 times creating 99 fake users in the DB
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = 'Password'
  User.create!(name:  name,
             email: email,
             password:              password,
             password_confirmation: password)
end
