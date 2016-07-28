class CreateRelTemplateItems < ActiveRecord::Migration
  def change
    create_table :rel_template_items do |t|
      t.string :name
      t.string :description
      t.text :note

      t.timestamps null: false
    end
  end
end
