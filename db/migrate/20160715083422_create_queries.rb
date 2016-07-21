class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :title
      t.text :statment

      t.timestamps null: false
    end
  end
end
