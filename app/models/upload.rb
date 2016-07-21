class Upload < ActiveRecord::Base
    has_attached_file :myfile
    belongs_to :release
    
    do_not_validate_attachment_file_type :myfile

end
