class AddIndexToConversation < ActiveRecord::Migration[8.0]
  def change
    add_index :conversations, [ :recipient_id, :sender_id ], unique: true
  end
end
