class ChangeSnIntegerToString < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :sn, :string
  end
end
