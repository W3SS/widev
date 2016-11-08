class UserProfile < ActiveRecord::Base

  belongs_to  :user, :class_name => 'User', :foreign_key => 'email', :validate => true , :primary_key => :email
  has_many :skills_to_profiles
  has_many :skills, through: :skills_to_profiles


  def latestSkills
  end

  def as_json(options={})
    super(:include => :skills_to_profiles)
  end

end
