class CreateDatabases < ActiveRecord::Migration
  def change
    create_table :databases do |t|
      t.string :sid
      t.string :user
      t.string :pass

      t.timestamps null: false
    end
  end
end
