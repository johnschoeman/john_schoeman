require 'sinatra/base'

module Sinatra
  module JavaScripts
    def js *scripts
      @js ||= []
      @js << scripts
    end

    def javascripts *args
      js = []
      js << args
      js << @js if @js
      js.flatten.uniq.map do |script|
        "<script src=\"#{path_to script}\"></script>"
      end.join
    end
  
    def path_to script
      case script
        when :recaptcha then 'https://www.google.com/recaptcha/api.js'
        else '/javascripts/' + script.to_s + '.js'
      end
    end
    
  end

  module HTMLEscape
    def h text
      Rack::Utils.escape_html text
    end
  end

  helpers JavaScripts, HTMLEscape
end