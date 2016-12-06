class CreateSiebelParameters < ActiveRecord::Migration
  def change
    create_table :siebel_parameters do |t|
      t.string :ptype
      t.string :pa_value
      t.string :pa_alias
      t.string :pa_setlevel
      t.string :server
      t.string :enterprise
      t.integer :version

      t.timestamps null: false
    end
  end
end
