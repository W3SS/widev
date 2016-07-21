class CreateWebservices < ActiveRecord::Migration
  def change
    create_table :webservices do |t|
      t.string :name
      t.string :int_endpoint
      t.string :bs
      t.string :bs_method
      t.string :applet
      t.string :applet_method
      t.text :description

      t.timestamps null: false
    end
  end
end
