require "obscenity"

class Art < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  before_save :sanitize_description

  validates :description, presence: true

  def sanitize_description
    self.description = Obscenity.sanitize(self.description)
  end
end
