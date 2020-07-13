require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('./controllers/pets_controller')
require_relative('./controllers/owners_controller')
require_relative('./controllers/treatments_controller')
require_relative('./controllers/vets_controller')

get '/' do
  erb( :index )
end