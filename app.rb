require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.development?
require 'sprockets'
require 'uglifier'
require 'sass'

require_relative 'models/project'
require_relative 'models/post'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :environment, Sprockets::Environment.new

  environment.append_path "public/stylesheets"
  environment.append_path "public/javascripts"

  environment.js_compressor = Uglifier.new(harmony: true)
  environment.css_compressor = :scss

  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets/", "")
    settings.environment.call(env)
  end

  get '/projects' do
    @projects = Project.all
    erb :index, :layout => false do
      erb :projects
    end
  end

  get '/posts/:post_name' do
    post = params['post_name']
    post_path = "views/posts/#{post}.erb"
    erb :index, :layout => false do
      File.exist?(post_path) ? (erb post.to_sym, views: 'views/posts') : (erb :not_found)
    end
  end

  get '/posts' do
    @posts = Post.all
    erb :index, :layout => false do
      erb :posts
    end
  end

  get '/resume' do
    erb :index, :layout => false do
      erb :resume
    end
  end

  get '/john_schoeman_resume.pdf' do
    send_file('john_schoeman_resume.pdf')
  end

  get '*' do
    erb :index, :layout => false do
      erb :about
    end
  end
end