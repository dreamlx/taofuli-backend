class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :url
      t.string :image
      t.integer :amount, default: 0
      t.string :state
      t.date :effective_date
      t.date :expire_date

      t.timestamps null: false
    end
  end
end
