class CreateItemPerTemplates < ActiveRecord::Migration
  def change
    create_table :item_per_templates do |t|
      t.belongs_to :rel_template, index: true
      t.belongs_to :rel_template_item, index: true
      t.timestamps null: false
    end
  end
end
