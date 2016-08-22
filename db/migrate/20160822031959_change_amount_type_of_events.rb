class ChangeAmountTypeOfEvents < ActiveRecord::Migration
  def up
    change_column :events, :amount, :decimal, precision: 12, scale: 2, default: 0
  end

  def down
    change_column :events, :amount, :integer, default: 0
  end
end
