User.create!(name:     "Test User",
             email:    "test@example.com",
             username: "test-user2022",
             password: "password")

20.times do |n|
  name  = Faker::Name.name
  username = name.split(" ").first.downcase + rand(1...1000).to_s
  email = "#{username}@example.com"
  password = "password"
  User.create!(name:     name,
               email:    email,
               username: username,
               password: password)
end

users = User.all
user  = users.first
following = users[2..20]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
