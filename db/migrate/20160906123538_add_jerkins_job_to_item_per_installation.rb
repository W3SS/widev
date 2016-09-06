class AddJerkinsJobToItemPerInstallation < ActiveRecord::Migration
  def change
    add_column :item_per_installations, :job_id , :String
    add_column :item_per_installations, :job_res_code , :String
  end
end
