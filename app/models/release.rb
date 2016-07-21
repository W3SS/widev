class Release < ActiveRecord::Base
    acts_as_commontable

    has_many :uploads

    
    def start_time
        self.date
    end
end
