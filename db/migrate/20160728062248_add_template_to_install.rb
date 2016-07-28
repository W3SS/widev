class AddTemplateToInstall < ActiveRecord::Migration
  def change
        add_reference :installations, :rel_template
  end
end
