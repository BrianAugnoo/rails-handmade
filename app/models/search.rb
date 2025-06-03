class Search
  def self.search_user(prompt)
    User.where(user_name: prompt).first(10)
  end
end
