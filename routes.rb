module App
  class SinatraSimpleLogin < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/login' do
      erb :login
    end

    get '/logout' do
      redirect '/'
    end

    get '/protected' do
      erb :protected
    end
  end
end