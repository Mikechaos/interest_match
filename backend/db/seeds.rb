# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.find_or_create_by(email: 'john@inc.com')

user.first_name = 'John'
user.first_name = 'Smith'
user.phone = "+1 555 222 1111"

user.interests.create(name: "pool", description: "I'm a pool expert")
user.interests.create(name: "chess", description: "I'm a chess experti as well")



