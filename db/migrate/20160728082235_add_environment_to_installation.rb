class AddEnvironmentToInstallation < ActiveRecord::Migration
  def change
            add_reference :installations, :environment
  end
end
