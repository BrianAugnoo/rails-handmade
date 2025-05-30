require 'faker'

puts "cleaning database..."
User.destroy_all
Art.destroy_all
Comment.destroy_all
Like.destroy_all
Notification.destroy_all
Message.destroy_all


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

puts "creating subscriptions..."
User.where.not(id: artist.id).each do |user|
  Subscription.create!(subscriber: artist, subscribed: user)
end

puts "creating conversations..."
User.where.not(id: artist.id).each do |user|
  if !Conversation.between?(artist, user)
    Conversation.create!(recipient: artist, sender: user)
  end
end

puts "creating messages..."
10.times do
  Message.create_in_conversation(content: Faker::Lorem.sentence, user: User.all.sample, recipient: User.all.sample)
end
Conversation.all.each do |conversation|
  Message.create!(content: Faker::Lorem.sentence, user: conversation.recipient, conversation: conversation)
end

puts "seeding done!"
