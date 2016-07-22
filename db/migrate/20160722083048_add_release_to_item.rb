class AddReleaseToItem < ActiveRecord::Migration
  def change
        add_reference :release_items, :release
  end
end
