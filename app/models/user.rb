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

  validate :normalize_phone_number
  validate :valid_phone_number

  has_one_attached :avatar

  def conversations
    Conversation.where("recipient_id = ? OR sender_id = ?", self.id, self.id)
  end

  def make_online!
    unless self.update_column(:connected, true)
      puts errors.full_messages
      raise
    end
    broadcast_append_to "conversations-icons",
                          target: "conversation-#{self.id}",
                          partial: "session/online_icon",
                          locals: { user: self }
  end

  def subscribed?(user)
    Subscription.exists?(subscriber_id: self.id, subscribed_id: user.id)
  end

  def subscription(user)
   Subscription.find_by(subscriber: self, subscribed: user)
  end

  def change_column(params)
    raise
  end

  private

  def valid_phone_number
    if phone_number.present? && !Phony.plausible?(phone_number)
      errors.add(:phone_number, "is not a valid phone number")
    elsif !phone_number.nil?
      true
    end
  end

  def normalize_phone_number
    if phone_number.present?
      normalized = Phony.normalize(phone_number)
      if normalized != phone_number
        self.phone_number = normalized
      end
    end
  rescue Phony::NormalizationError => e
    errors.add(:phone_number, "could not be normalized: #{e.message}")
  rescue StandardError => e
    errors.add(:phone_number, "is invalid: #{e.message}")
  end
end
