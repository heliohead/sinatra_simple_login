module App
  class SinatraSimpleLogin < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    env['warden'].authenticate!

    flash[:success] = env['warden'].message

    if session[:return_to].nil?
      redirect '/'
    else
      redirect session[:return_to]
    end
  end

  get '/logout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    flash[:success] = 'Successfully logged out'
    redirect '/'
  end

  post '/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?
    puts env['warden.options'][:attempted_path]
    puts env['warden']
    flash[:error] = env['warden'].message || "You must log in"
    redirect '/login'
  end

  get '/protected' do
    env['warden'].authenticate!

    erb :protected
  end
end