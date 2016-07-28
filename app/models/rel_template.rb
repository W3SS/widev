class RelTemplate < ActiveRecord::Base
    has_many :item_per_template
    has_many :rel_template_item, through: :item_per_template
end
