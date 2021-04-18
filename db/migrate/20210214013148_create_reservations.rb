class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :reserved_at
      t.string :reserved_time_slot
      t.string :name
      t.string :kana
      t.date :birthday_on
      t.string :phone_number
      t.boolean :proxy_input
      t.datetime :imported_at
      t.references :imported_user_id, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
