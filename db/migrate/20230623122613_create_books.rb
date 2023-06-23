class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author_name
      t.integer :price
      t.string :isbn
      t.integer :quantity_available

      t.timestamps
    end
  end
end
