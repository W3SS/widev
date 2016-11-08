class AddSkillAndProfileToSkillToProfile < ActiveRecord::Migration
  def change
    add_reference :skills_to_profiles , :skill, index: true
    add_reference :skills_to_profiles , :user_profile, index: true

  end
end
