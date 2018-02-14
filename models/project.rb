require 'csv'

class Project
  attr_accessor :title, :github_url, :site_url, :date, :description, :skills
  
  def initialize(title, github_url, site_url, date, description, skills)
    @title = title
    @github_url = github_url
    @site_url = site_url
    @date = date
    @description = description
    @skills = skills.split('--')
  end

  def self.all
    file = File.expand_path("../projects.csv", __FILE__)
    data = CSV.read(file, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all })
    hashed_data = data.map { |row| row.to_hash }
    hashed_data.map { |row| new(row[:title], row[:github_url], row[:site_url], row[:date], row[:description], row[:skills]) }
  end
end