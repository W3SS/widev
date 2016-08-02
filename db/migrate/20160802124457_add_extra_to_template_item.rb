class AddExtraToTemplateItem < ActiveRecord::Migration
  def change
    add_column :item_per_installations, :is_extra ,:boolean
  end
end
