class AddConnectedToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :connected, :boolean, default: false, null: false
    add_index :users, :connected
  end
end
