class CreateBooks < ActiveRecord::Migration[4.2]
  def change
    create_table :books do |t|
      t.string :asin
      t.string :title
      t.string :author

      t.timestamps null: false
    end
  end
end
