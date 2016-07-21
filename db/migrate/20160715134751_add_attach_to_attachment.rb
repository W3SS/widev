class AddAttachToAttachment < ActiveRecord::Migration
  def change
    
    
    def up
    add_attachment :attachments, :myfile
  end

  def down
    remove_attachment :attachments, :myfile
  end
  end
end
