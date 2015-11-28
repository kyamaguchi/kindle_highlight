class AddLastAnnotatedOnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :last_annotated_on, :date
  end
end
