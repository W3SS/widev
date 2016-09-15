class AddTestReleaseDateToReleaseItem < ActiveRecord::Migration
  def change
    add_column :release_items, :test_env_date, :date
  end
end
