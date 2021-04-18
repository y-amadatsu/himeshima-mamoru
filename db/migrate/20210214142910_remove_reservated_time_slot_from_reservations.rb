class RemoveReservatedTimeSlotFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :reserved_time_slot, :string
  end
end
