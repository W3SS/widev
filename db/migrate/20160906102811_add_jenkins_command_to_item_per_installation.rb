class AddJenkinsCommandToItemPerInstallation < ActiveRecord::Migration
  def change
    add_column :item_per_installations, :command, :String
  end
end
