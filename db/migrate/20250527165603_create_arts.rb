class CreateArts < ActiveRecord::Migration[8.0]
  def change
    create_table :arts do |t|
      t.text :description
      t.string :tags
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
