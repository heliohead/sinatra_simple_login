module App
  class SinatraSimpleLogin < Sinatra::Base
    use Rack::Session::Cookie, secret: "UnSecretKey"
    use Rack::Flash, accessorize: [:error, :success]

    enable :sessions

    use Warden::Manager do |config|
      config.serialize_into_session{|user| user.id }
      config.serialize_from_session{|id| User.get(id) }
      config.scope_defaults :default,
        strategies: [:password],
        action: 'unauthenticated'
      config.failure_app = self
    end

    Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    Warden::Strategies.add(:password) do
      def flash
        env['x-rack.flash']
      end

      def valid?
        params['user'] && params['user']['email'] && params['user']['password']
      end

      def authenticate!
        user = User.first(email: params['user']['email'])

        if user.nil?
          fail!("The email you entered does not exist.")
          flash.error = ""
        elsif user.authenticate(params['user']['password'])
          success!(user)
        else
          fail!("Could not log in")
        end
      end
    end
  end
end