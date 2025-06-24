class Search
  def self.user(query, current_user)
    query = query.match(/\S.*\S*/)
    result = { existing_conversation: [], inexsting_conversation: [] }
    if query.present?
      users = User.where("user_name ILIKE ?", "%#{query}%")
      users.each do |user|
        Conversation.between?(user, current_user) ? result[:existing_conversation] << Conversation.between(user, current_user) : result[:inexsting_conversation] << user
      end
    end
    result
  end

  def self.all_users(query)
    query = query.match(/\S.*\S*/)
    if query.present?
      User.where("user_name ILIKE ?", "%#{query}%")
    else
      nil
    end
  end

  def self.arts(query)
    query = query.match(/\S.*\S*/)
    if query.present?
      Art.where("tags ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
    else
      nil
    end
  end

  def self.art(query)
    Art.where("tags ILIKE ?", "%#{query}%").first(10)
  end
end
