class AssSystemToRelease < ActiveRecord::Migration
  def change
    add_reference :releases, :system
  end
end
