# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Yumemi = User.find_or_create_by!(email: "yume@yume") do |user|
  user.name = "yumemi"
  user.password = "123456789"
  user.password_confirmation = "123456789"
  user.admin = true
end