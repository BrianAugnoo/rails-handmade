class Search
  def self.user(query, current_user)
    users = User.where("user_name ILIKE ?", "%#{query}%")
    result = { existing_conversation: [], inexsting_conversation: [] }
    users.each do |user|
      Conversation.between?(user, current_user) ? result[:existing_conversation] << Conversation.between(user, current_user) : result[:inexsting_conversation] << user
    end
    result
  end

  def self.art(query)
    Art.where("tags ILIKE ?", "%#{query}%").first(10)
  end
end
