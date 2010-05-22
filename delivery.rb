require 'rubygems'
require 'sinatra'
require 'geokit'
require 'mustache/sinatra'
require 'json'

class Delivery < Sinatra::Base
  register Mustache::Sinatra
  set :mustache, {:views => 'views', :templates => 'templates'}
  set :public, '/public'
  get '/' do
    mustache :index
  end
  
  post '/' do
    content_type :json
    address = params[:address]
    query = Geokit::Geocoders::YahooGeocoder.geocode address
    distance = query.distance_from('12 West 27th Street, New York, New York')
    return distance > 2.0 ? "false" : "true"
  end
  
end
