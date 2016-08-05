class Installation < ActiveRecord::Base
    has_many :item_per_installation
    has_many :rel_template_item, through: :item_per_installation
    belongs_to :environment
    acts_as_commontable

end
