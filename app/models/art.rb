require "obscenity"

class Art < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  before_save :sanitize_description

  validates :description, presence: true
  has_one_attached :photo
  has_one_attached :video

  private
  # Sanitize the description to remove profanity
  def sanitize_description
    self.description = Obscenity.sanitize(self.description)
  end
end
