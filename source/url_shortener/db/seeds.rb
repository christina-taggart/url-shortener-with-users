class UsersSeeder
  User.create(name:"John Olmsted", email: "john@example.com", password: "supersecret")
  User.create(name:"Rick Rubio", email: "rick@example.com", password: "secret1")
  10.times { User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Lorem.word) }
end