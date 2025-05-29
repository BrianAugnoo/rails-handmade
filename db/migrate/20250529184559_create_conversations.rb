class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.references :recipient, user: true, null: false, foreign_key: true
      t.references :sender, user: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
