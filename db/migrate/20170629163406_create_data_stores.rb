class CreateDataStores < ActiveRecord::Migration
  def change
    create_table :data_stores do |t|
      t.string :key
      t.json :content

      t.timestamps null: false
    end
  end
end
