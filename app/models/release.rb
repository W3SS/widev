class Release < ActiveRecord::Base
    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }
    acts_as_commontable

    has_many :uploads
    belongs_to :system
    belongs_to :reltype
    has_many :release_items

    def start_time
        self.date
    end
end
