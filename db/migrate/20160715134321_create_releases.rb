class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :rel
      t.text :note
      t.text :outcome
      t.datetime :date
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
