require 'faker'

puts "cleaning database..."
User.destroy_all
puts "users destroyed"
Art.destroy_all
puts "arts destroyed"
Comment.destroy_all
puts "comments destroyed"
Like.destroy_all
puts "likes destroyed"
Notification.destroy_all
puts "notifications destroyed"

puts "creating users..."
artist = User.create!(user_name: "artist", password: ENV["USER_PASSWORD"], password_confirmation: ENV["USER_PASSWORD"], email: "artist@exemple.com", phone_number: "+33612345679")
10.times do
  User.create!(user_name: Faker::Name.name, password: ENV["USER_PASSWORD"], password_confirmation: ENV["USER_PASSWORD"], email: Faker::Internet.email)
end

puts "creating arts..."
10.times do
  Art.create!(description: Faker::Lorem.sentence, user: artist, tags: "#art, #painting, #digital")
end

puts "creating comments..."
10.times do
  Comment.create!(review: Faker::Lorem.sentence, user: User.all.sample, art: Art.all.sample)
end

puts "creating likes..."
10.times do
  Like.create!(user: User.all.sample, art: Art.all.sample)
end

puts "creating notifications..."
10.times do
  Notification.create!(user: User.all.sample, content: Faker::Lorem.sentence)
end

puts "create suscribers..."
10.times do
  Subscriber.create!(user: User.where.not(id: artist.id).sample, subscription: artist.subscription)
end

# puts "create conversations..."
# 10.times do
#   Conversation.create!(user: User.all.sample, chat: artist.chat)
# end
