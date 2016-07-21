class Webservice < ActiveRecord::Base
    
 
def self.import(file)
     
     logger.info ("Start importing")
      spreadsheet = Roo::Spreadsheet.open(file)
     
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        logger.info(row);
        webservice = find_by_id(row["id"]) || new
        webservice.attributes = row.to_hash.slice(*Webservice.attribute_names())
        webservice.save!
      end
end

def accessible_attributes
  ['id','name','int_endpoint']
end

 
  
end
