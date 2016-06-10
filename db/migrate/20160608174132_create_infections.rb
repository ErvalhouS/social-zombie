class CreateInfections < ActiveRecord::Migration
  def change
    create_table :infections do |t|
      t.references :survivor
      t.references :reporter

      t.timestamps null: false
    end
  end
end
