
class ReleaseItem < ActiveRecord::Base
    
    belongs_to :release

    def getlatestrel(i)
        logger.info(i.name)
        name = i.name
        item = ReleaseItem.includes(:release).where("name like ?", name.strip )
                                             .where("releases.id <> "+ i.release_id.to_s)
                                             .where("releases.date <  ?", i.release.date)
                                             .order("releases.date desc").first

        if item
          return item
        else
            return nil
        end
    end

    def getReleaseDate(item)
        rel = item.file_name[0..10]
        logger.info (rel)
        dt=ReleaseManager.getDateForRelaase(rel)
        logger.info ("DT " << dt)
        if dt != nil
          return dt
        else
          return nil
        end

    end

    def self.import(file,release)

          logger.info ("Start importing")
          xlsx = Roo::Spreadsheet.open(file)
          logger.info(xlsx.info)

          sheet = xlsx.sheets
          xlsx.each_with_pagename do |name, sheet|
            type = name

            if sheet.first_row

                ((sheet.first_row + 1)..sheet.last_row).each do |row|

                    file_name = sheet.row(row)[0]
                    removable_s= sheet.row(row)[1]
                    removable = false
                    if removable_s == "Y" || removable_s == "y"
                      removable = true
                    end
                    item = ReleaseItem.new
                    item.ftype = name.upcase
                    item.file_name = file_name
                    item.name = file_name[12r..-1]
                    item.release_id = release
                    item.removable = removable
                    item.test_env_date = item.getReleaseDate(item)
                    item.save!
                  end
            end
         end


    end

    def accessible_attributes
      ['id','name','type']
    end

 
  
  
end
