class AddTrustToArt < ActiveRecord::Migration[8.0]
  def change
    add_column :arts, :trust, :float, null: false, default: 0.0
  end
end
