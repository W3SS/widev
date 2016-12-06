class AddComponentToSiebelParameters < ActiveRecord::Migration
  def change
    add_column :siebel_parameters ,  :component , :string
  end
end
