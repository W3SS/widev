class CreateRelTemplates < ActiveRecord::Migration
  def change
    create_table :rel_templates do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
