class RenameTypeColum < ActiveRecord::Migration
  def change
    rename_column :release_items, :type, :ftype

  end
end
