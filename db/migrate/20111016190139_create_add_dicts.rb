class CreateAddDicts < ActiveRecord::Migration
  def change
    create_table :add_dicts do |t|
      t.string :file

      t.timestamps
    end
  end
end
