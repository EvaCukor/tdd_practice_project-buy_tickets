class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :event_id, :user_id
      t.integer :number_of_tickets, :ticket_price
      t.string :ticket_type
      t.timestamps
    end
  end
end
