class CreateReltypes < ActiveRecord::Migration
  def change
    create_table :reltypes do |t|
      t.string :name
      t.string :color
      t.string :short

      t.timestamps null: false
    end
  end
end
