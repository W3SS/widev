class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name
      t.string :color
      t.string :short

      t.timestamps null: false
    end
  end
end
