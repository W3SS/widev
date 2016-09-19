class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :description
      t.string :is_available

      t.timestamps null: false
    end
  end
end
