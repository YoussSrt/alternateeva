class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :address
      t.string :category
      t.string :website
      t.string :tags

      t.timestamps
    end
  end
end
