class Like < ApplicationRecord
  attr_accessor :current_user
  attr_accessor :skip_broadcast
  belongs_to :user
  belongs_to :art
  after_create_commit :create_broadcast, unless: -> { skip_broadcast }

  def self.liked?(user, art)
     exists?(user: user, art: art)
  end

  def create_broadcast
    broadcast_update_to "turbo_#{self.art.id}_likes",
                         target: "art_#{self.art.id}_likes",
                         partial: "home/like",
                         locals: { current_user: self.current_user, art: self.art }
  end
end
