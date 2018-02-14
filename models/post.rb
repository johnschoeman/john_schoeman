require 'csv'

class Post
  attr_accessor :date, :href, :title, :description
  
  def initialize(date, href, title, description)
    @date = date
    @href = href
    @title = title
    @description = description
  end

  def self.all
    file = File.expand_path("../posts.csv", __FILE__)
    data = CSV.read(file, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all })
    hashed_data = data.map { |row| row.to_hash }
    hashed_data.map { |row| new(row[:date], row[:href], row[:title], row[:description]) }
  end
end