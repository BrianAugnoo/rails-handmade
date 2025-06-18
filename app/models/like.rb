class Like < ApplicationRecord
  belongs_to :user
  belongs_to :art

  def self.liked?(user, art)
     exists?(user: user, art: art)
  end
end
