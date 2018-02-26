require 'csv'

class ApplicationRecord
  def self.all
    file = File.expand_path("../#{self.to_s.downcase}s.csv", __FILE__)
    data = CSV.read(file, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all })
    hashed_data = data.map { |row| new(row.to_hash) }
  end
end