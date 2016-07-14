class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :openid
      t.string :name
      t.string :gender
      t.string :cell
      t.string :email
      t.string :state

      t.timestamps null: false
    end
  end
end
