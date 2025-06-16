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
  has_many :subscribers, class_name: "Subscription", foreign_key: "subscriber_id", dependent: :destroy
  has_many :subscribeds, class_name: "Subscription", foreign_key: "subscribed_id", dependent: :destroy
  has_many :conversation_as_recipients, class_name: "Conversation", foreign_key: "recipient_id", dependent: :destroy
  has_many :conversation_as_senders, class_name: "Conversation", foreign_key: "sender_id", dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :user_name, presence: true, uniqueness: true
  validates :password, format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/, message: "the password must contain a capital letter and a number" }
  validate :valid_phone_number
  validates :phone_number, uniqueness: true, if: :valid_phone_number

  def conversations
    Conversation.where("recipient_id = ? OR sender_id = ?", self.id, self.id)
  end

  def online
    broadcast_append_to "conversations-icons",
                          target: "conversation-#{self.id}",
                          partial: "session/online_icon",
                          locals: { user: self }
  end

  private

  def valid_phone_number
    if phone_number.present? && !Phony.plausible?(phone_number)
      errors.add(:phone_number, "is not a valid phone number")
    elsif !phone_number.nil?
      true
    end
  end
end
