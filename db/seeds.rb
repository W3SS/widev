# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


(0..100).each() do |i|
  puts i
  user = User.create( :email => Faker::Internet.email, :password => "fooo")
end

Time:;TimeReport.create (:hours =>8, :time_reason_id =>0, :user_id =>2, :repdate => Date.today)