User.create!(name:     "Test User",
             email:    "test-user@example.com",
             username: "test-user",
             password: "password")

50.times do |n|
  name  = Faker::Name.name
  username = name.split(" ").first.downcase + rand(1...1000).to_s
  email = "#{username}@example.com"
  password = "password"
  User.create!(name:     name,
               email:    email,
               username: username,
               password: password)
end
