require "phony"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :arts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :subscribers, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_one :chat, dependent: :destroy

  validates :user_name, presence: true, uniqueness: true
  validates :password, format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/, message: "the password must contain a capital letter and a number" }
  validate :valid_phone_number
  validates :phone_number, uniqueness: true, if: :valid_phone_number
  after_create :create_subscription
  after_create :create_chat

  private

  def valid_phone_number
    if phone_number.present? && !Phony.plausible?(phone_number)
      errors.add(:phone_number, "is not a valid phone number")
    elsif !phone_number.nil?
      true
    end
  end

  def create_subscription
    Subscription.create!(user_id: self.id)
  end

  def create_chat
    Chat.create!(user_id: self.id)
  end
end
