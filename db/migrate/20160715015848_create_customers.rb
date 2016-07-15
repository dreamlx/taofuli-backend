class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :cell
      t.string :qq
      t.text :desc
      t.string :state
      t.text :note

      t.timestamps null: false
    end
  end
end
