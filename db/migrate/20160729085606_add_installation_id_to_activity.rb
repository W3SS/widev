class AddInstallationIdToActivity < ActiveRecord::Migration
  def change
     add_column :activities , :installation_id ,:integer
  end
end