require 'sinatra/base'
require 'sprockets'
require 'uglifier'

class App < Sinatra::Base

  set :environment, Sprockets::Environment.new

  environment.append_path "public/stylesheets"
  environment.append_path "public/javascripts"

  environment.js_compressor  = Uglifier.new(harmony: true)

  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets/", "")
    settings.environment.call(env)
  end


  get '/projects' do
    @projects = [
      Project.new('Product Hunt App', 'productjadt.com', 'a cool site'),
      Project.new('Ready Responder Alert', 'readyresponderalert.com', 'a cool iot project')
    ]
    erb :index, :layout => false do
      erb :projects
    end
  end

  get '/resume' do
    erb :index, :layout => false do
      erb :resume
    end
  end

  get '*' do
    erb :index, :layout => false do
      erb :about
    end
  end
end

class Project
  attr_accessor :title, :link_url, :description
  
  def initialize(title, link_url, description)
    @title = title
    @link_url = link_url
    @description = description
  end
end