class AddNaToIntemPerInstallatin < ActiveRecord::Migration
  def change
    add_column :item_per_installations, :is_na , :boolean
  end
end
