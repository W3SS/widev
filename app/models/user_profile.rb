class UserProfile < ActiveRecord::Base

  belongs_to  :user, :class_name => 'User', :foreign_key => 'email', :validate => true , :primary_key => :email

end
