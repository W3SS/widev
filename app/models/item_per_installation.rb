class ItemPerInstallation < ActiveRecord::Base
    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user } 
    belongs_to :rel_template_item
    belongs_to :installation
end
