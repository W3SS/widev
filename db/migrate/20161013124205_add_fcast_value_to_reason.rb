class AddFcastValueToReason < ActiveRecord::Migration
  def change
    add_column :time_reasons, :fcast_value, :float ,default: 8
    add_column :time_reasons, :chageable, :boolean, default: true


  end
end
