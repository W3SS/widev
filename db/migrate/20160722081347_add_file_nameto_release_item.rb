class AddFileNametoReleaseItem < ActiveRecord::Migration
  def change
    add_column :release_items , :file_name, :string
  end
end
