class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :venue, :img_url
      t.text :description
      t.date :date
      t.time :time
      t.integer :category_id, :floor_ticket_price, :balcony_ticket_price
      t.timestamps
    end
  end
end
