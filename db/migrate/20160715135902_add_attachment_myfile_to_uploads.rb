class AddAttachmentMyfileToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :myfile
    end
  end

  def self.down
    remove_attachment :uploads, :myfile
  end
end
