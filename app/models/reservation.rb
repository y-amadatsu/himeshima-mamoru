# frozen_string_literal: true

require 'csv'

class Reservation < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :imported_user_id, optional: true, inverse_of: :reservation

  def age
    (Time.zone.today.strftime('%Y%m%d').to_i - birthday_on.strftime('%Y%m%d').to_i) / 10_000
  end

  # TODO: 編集すること！
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      book = find_by(id: row['id']) || new
      book.attributes = row.to_hash.slice(*updatable_attributes)
      book.save!(validate: false)
    end
  end
end
