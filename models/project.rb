require_relative './application_record'

class Project < ApplicationRecord
  attr_accessor :title, :github_url, :site_url, :date, :description, :skills
  
  def initialize(params)
    @title = params[:title]
    @github_url = params[:github_url]
    @site_url = params[:site_url]
    @date = params[:date]
    @description = params[:description]
    @skills = params[:skills].split('--')
  end
end