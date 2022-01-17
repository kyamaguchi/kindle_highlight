class AddColorToHighlights < ActiveRecord::Migration[4.2]
  def change
    add_column :highlights, :color, :string
  end
end
