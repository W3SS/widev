class AddDetailToEnvironment < ActiveRecord::Migration
  def change
    add_column :environments, :rel_type, :string
    add_column :environments, :rel, :string
    add_column :environments, :stype, :string
    add_column :environments, :int_system, :string
  end
end
