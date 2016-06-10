class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :item_value
      t.references :survivor

      t.timestamps null: false
    end
  end
end
