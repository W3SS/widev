class CreateCheckResults < ActiveRecord::Migration
  def change
    create_table :check_results do |t|
      t.text :value
      t.references :query_check, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
