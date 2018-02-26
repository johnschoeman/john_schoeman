require 'sinatra/base'
require 'sprockets'
require 'uglifier'
require 'sass'

if Sinatra::Base.development?
  require 'sinatra/reloader'
  require 'dotenv/load'
end

require_relative 'sinatra/helpers'
require_relative 'models/project'
require_relative 'models/post'

class App < Sinatra::Base
  helpers Sinatra::JavaScripts
  helpers Sinatra::HTMLEscape

  configure :development do
    register Sinatra::Reloader
  end

  set :environment, Sprockets::Environment.new

  environment.append_path "public/stylesheets"
  environment.append_path "public/javascripts"

  environment.js_compressor = Uglifier.new(harmony: true)
  environment.css_compressor = :scss

  set :email_username, ENV['SENDGRID_USERNAME'] || ENV['GMAIL_USERNAME']
  set :email_password, ENV['SENDGRID_PASSWORD'] || ENV['GMAIL_PASSWORD']
  set :email_address, 'johnschoeman1729@gmail.com'
  set :email_service, ENV['EMAIL_SERVICE'] || 'gmail.com'
  set :email_domain, ENV['EMAIL_DOMAIN'] || 'localhost.localdomain'

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

  get '/about' do
    @name, @email, @message = params[:name], params[:email], params[:message]
    js "email_alert_#{params[:email_status]}".to_sym if params[:email_status]
    erb :index, :layout => false do
      erb :about
    end
  end

  get '*' do
    erb :index, :layout => false do
      erb :about
    end
  end

  post '/contact' do
    require 'pony'

    path_with_params = ->(path) do 
      path + "&name=#{params[:name]}&email=#{params[:email]}&message=#{params[:message]}"
    end

    redirect_path = ->(email_status) do
      path = "/about?email_status=#{email_status}"
      email_status == 'success' ? path : path_with_params.call(path)
    end
    
    if params["g-recaptcha-response"].nil? || params["g-recaptcha-response"].empty? || !params[:honeypot].empty?
      redirect redirect_path.call('captcha_failure')
    end

    begin
      Pony.mail({
        from: params[:name] + "<" + params[:email] + ">",
        to: settings.email_address,
        subject: "john-schoeman.com: " + params[:name] + " has sent you a message",
        body: params[:message] + " " + params[:email],
        via: :smtp,
        via_options: {
          address:               'smtp.' + settings.email_service,
          enable_starttls_auto:  true,
          port:                  '587',
          user_name:             settings.email_username,
          password:              settings.email_password,
          authentication:        :plain,
          domain:                settings.email_domain
        }
      })
      redirect redirect_path.call('success')
    rescue
      redirect redirect_path.call('failure')
    end
  end
end