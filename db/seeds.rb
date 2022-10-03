# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
%w[admin provider client].each do |user_type|
  User.create!(
    :email => "#{user_type}@mail.com",
    :password => '123456',
    :password_confirmation => '123456',
    :user_type => user_type.to_sym
  )
  puts "To login as #{user_type} use email: #{user_type}@mail.com and password: 123456"
end


