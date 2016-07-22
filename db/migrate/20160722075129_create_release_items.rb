class CreateReleaseItems < ActiveRecord::Migration
  def change
    create_table :release_items do |t|
      t.string :name
      t.string :type
      t.boolean :scratchable
      t.boolean :remove

      t.timestamps null: false
    end
  end
end
