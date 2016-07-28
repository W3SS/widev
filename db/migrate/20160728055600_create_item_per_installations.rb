class CreateItemPerInstallations < ActiveRecord::Migration
  def change
    create_table :item_per_installations do |t|
      t.belongs_to :rel_template_item
      t.date :start_time
      t.date :end_time
      t.belongs_to :installation
      t.boolean :is_done
      t.boolean :is_started
      t.boolean :is_error
      t.text :note

      t.timestamps null: false
    end
  end
end
