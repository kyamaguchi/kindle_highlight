class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.references :book, index: true, foreign_key: true
      t.text :content
      t.integer :location
      t.string :annotation_id
      t.text :note
      t.string :note_id
      t.datetime :fetched_at

      t.timestamps null: false
    end
  end
end
