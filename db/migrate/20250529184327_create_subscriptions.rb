class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscriber, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
