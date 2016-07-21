class AddReleaseRefToUploads < ActiveRecord::Migration
  def change
    add_reference :uploads, :release, index: true, foreign_key: true
  end
end
