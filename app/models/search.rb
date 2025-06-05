class Search
  def self.user(query)
    User.where("user_name ILIKE ?", "%#{query}%").first(10)
  end

  def self.art(query)
    Art.where("tags ILIKE ?", "%#{query}%").first(10)
  end

  def self.global(query)
    users = self.user(query)
    arts = self.art(query)
    { users: users, arts: arts }
  end
end
