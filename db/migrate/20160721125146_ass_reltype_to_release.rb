class AssReltypeToRelease < ActiveRecord::Migration
  def change
        add_reference :releases, :reltype

  end
end
