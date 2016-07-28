class ChangeDateToDatetimeOnItePerInstall < ActiveRecord::Migration
  def change
    change_column :item_per_installations, :start_time, :datetime
    change_column :item_per_installations, :end_time, :datetime
  end
end
