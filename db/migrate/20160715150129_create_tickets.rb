class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text :ticket
      t.text :token
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
