class ItemPerTemplate < ActiveRecord::Base
     belongs_to :rel_template_item
     belongs_to :rel_template
end
