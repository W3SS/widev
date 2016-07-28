class ItemPerInstallation < ActiveRecord::Base
    belongs_to :rel_template_item
    belongs_to :installation
end
