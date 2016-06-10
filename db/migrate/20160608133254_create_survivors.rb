class CreateSurvivors < ActiveRecord::Migration
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender, limit: 1
      t.float :lat
      t.float :lng
      t.string :ip_address

      t.timestamps null: false
    end
  end
end
