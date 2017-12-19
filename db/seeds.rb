# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Category
Category.destroy_all

category_list =[
  {name: "Chinese Cuisine"},
  {name: "Japanese Cuisine"},
  {name: "American Cuisine"},
  {name: "Italian Cuisine"},
  {name: "Mexican Cuisine"},
  {name: "Vegetarian Cuisine"},
  {name: "Fusion Cuisine"}
]

category_list.each do |category|
  Category.create( name: category[:name] )
end
puts "Category created!"

# Defult admin
User.create(email: "waynn7788@gmail.com", password: "abcd7890", role: "admin")
puts "Default admin created!"
