class AddTimingToAddDicts < ActiveRecord::Migration
  def change
    add_column :add_dicts, :timing, :integer
  end
end
