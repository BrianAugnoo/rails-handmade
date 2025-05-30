class AddIndexToMessage < ActiveRecord::Migration[8.0]
  def change
    add_index :messages, :created_at
  end
end
