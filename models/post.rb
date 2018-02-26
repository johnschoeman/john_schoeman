require_relative './application_record'

class Post < ApplicationRecord
  attr_accessor :date, :href, :title, :description, :tags
  
  def initialize(params)
    @date = params[:date]
    @href = params[:href]
    @title = params[:title]
    @description = params[:description]
    @tags = params[:tags].split('--')
  end
end