class AddJenkinsCommandToReleaseItems < ActiveRecord::Migration
  def change
    add_column :rel_template_items, :command,  :String

  end
end
