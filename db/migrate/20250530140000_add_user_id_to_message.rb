class AddUserIdToMessage < ActiveRecord::Migration[8.0]
  def change
    add_reference :messages, :user, null: false, foreign_key: true
    add_column :messages, :read, :boolean, default: false
  end
end
