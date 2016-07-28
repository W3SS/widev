class AddStatusToInstallation < ActiveRecord::Migration
  def change
        add_column :installations , :is_started, :boolean
        add_column :installations , :is_done, :boolean

  end
end
