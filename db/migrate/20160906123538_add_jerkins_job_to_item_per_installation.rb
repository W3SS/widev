class AddJerkinsJobToItemPerInstallation < ActiveRecord::Migration
  def change
    add_column :item_per_installations, :job_id , :string
    add_column :item_per_installations, :job_res_code , :string
  end
end
