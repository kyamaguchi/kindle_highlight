class AddLastAnnotatedOnToBooks < ActiveRecord::Migration[4.2]
  def change
    add_column :books, :last_annotated_on, :date
  end
end
