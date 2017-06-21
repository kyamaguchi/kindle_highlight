class AddColorToHighlights < ActiveRecord::Migration
  def change
    add_column :highlights, :color, :string
  end
end
