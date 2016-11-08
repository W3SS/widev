class AddSkillTeamToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :skill_team, :string
  end
end
