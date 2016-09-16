class AddRemovableToReleaseItem < ActiveRecord::Migration
  def change
    add_column :release_items , :removable, :boolean
  end
end
