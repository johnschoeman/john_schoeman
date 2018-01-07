require 'csv'

class Project
  attr_accessor :title, :link_url, :date, :description
  
  def initialize(title, link_url, date, description)
    @title = title
    @link_url = link_url
    @date = date
    @description = description
  end

  def self.all
    file = File.expand_path("../projects.csv", __FILE__)
    data = CSV.read(file, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all })
    hashed_data = data.map { |row| row.to_hash }
    hashed_data.map { |row| new(row[:title], row[:link_url], row[:date], row[:description]) }
  end
end