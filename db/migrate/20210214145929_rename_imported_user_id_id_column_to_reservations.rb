class RenameImportedUserIdIdColumnToReservations < ActiveRecord::Migration[6.1]
  def change
    rename_column :reservations, :imported_user_id_id, :imported_user_id
  end
end
