class ChangeUrlTypeOfEvents < ActiveRecord::Migration
  def up
    change_column :events, :url, :text
  end

  def down
    change_column :events, :url, :string
  end
end
