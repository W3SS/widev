class Webservice < ActiveRecord::Base

 


def self.import(file)
      logger.info ("Start importing")
      xlsx = Roo::Spreadsheet.open(file)
      logger.info(xlsx.info)
      
      sheet = xlsx.sheet(0)
        if sheet.first_row
            ((sheet.first_row + 1)..sheet.last_row).each do |row|
                logger.info (sheet.row(row)[0])
                ws =  Webservice.new
                ws.name=sheet.row(row)[0]
                ws.int_endpoint=sheet.row(row)[1]
                ws.bs=sheet.row(row)[3]
                ws.bs_method=sheet.row(row)[4]
                ws.applet=sheet.row(row)[5]
                ws.applet_method=sheet.row(row)[6]
                ws.workflow=sheet.row(row)[7]
                ws.involvedflow=sheet.row(row)[8]
                ws.comments =sheet.row(row)[9]
                ws.save!
              end
        end
end




def accessible_attributes
  ['id','name','int_endpoint']
end

 
  
end
