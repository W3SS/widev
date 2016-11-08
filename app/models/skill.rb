class Skill < ActiveRecord::Base


  def getValueForProfile (profile)
    return SkillsToProfile.where(skill_id: self.id ,user_profile_id: profile.id).first
  end
end
