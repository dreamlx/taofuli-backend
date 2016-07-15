class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.integer :amount
      t.string :state
      t.date :date

      t.timestamps null: false
    end
  end
end
