class AddQuotaToEvents < ActiveRecord::Migration
  def change
    add_column :events, :quota, :integer, default: 0
    add_column :events, :content, :text
    add_column :events, :official_benefit, :text
    add_column :events, :additional_benefit, :text
  end
end
