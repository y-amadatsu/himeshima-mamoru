# frozen_string_literal: true

require 'csv'

headers = %w[Id ResevedAt Name Kana BirthdayOn PhotoNumber ProxyInput CreatedAt UpdatedAt]
csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: true) do |csv|
  @reservations.each do |r|
    column_values = [
      r.id,
      I18n.l(r.reserved_at, format: :short),
      r.name,
      r.kana,
      I18n.l(r.birthday_on),
      r.phone_number,
      r.proxy_input,
      I18n.l(r.created_at),
      I18n.l(r.updated_at)
    ]
    csv << column_values
  end
end
csv_data.encode(Encoding::SJIS)
