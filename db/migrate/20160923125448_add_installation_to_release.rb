class AddInstallationToRelease < ActiveRecord::Migration
  def change
    add_reference :releases, :installation, index: true

  end
end
