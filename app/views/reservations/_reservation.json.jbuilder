# frozen_string_literal: true

json.extract! reservation, :id, :reserved_at, :reserved_time_slot, :name, :kana, :birthday_on, :phone_number,
              :proxy_input, :imported_at, :imported_by, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
