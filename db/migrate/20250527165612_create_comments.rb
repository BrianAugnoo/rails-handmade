class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :review
      t.references :user, null: false, foreign_key: true
      t.references :art, null: false, foreign_key: true

      t.timestamps
    end
  end
end
