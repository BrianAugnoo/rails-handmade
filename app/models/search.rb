class Search
  def self.search_user(prompt)
    User.where("user_name ILIKE ?").first(10)
  end
end
