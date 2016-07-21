class Query < ActiveRecord::Base
   include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }

    acts_as_taggable 
end
