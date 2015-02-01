require 'bundler'
Bundler.require

use Rack::Session::Cookie, secret: "UnSecretKey"
use Rack::Flash, accessorize: [:error, :success]

require './model'
require './routes'
