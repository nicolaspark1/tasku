# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin_email = "admin@example.com"
admin_password = "Colorado438"

unless User.exists?(email: admin_email)
  User.create({
    :email => admin_email,
    :password => admin_password,
    :role => "admin",
    :name => "Admin User"
  })
  puts "Admin user created with email: #{admin_email}"
else
  puts "Admin user with email #{admin_email} already exists"
end
