require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('./controllers/pets_controller')
require_relative('./controllers/owners_controller')
require_relative('./controllers/treatments_controller')
require_relative('./controllers/vets_controller')
require_relative('./controllers/pet_treatments_controller')
require_relative('./controllers/payments_controller')
require_relative('./controllers/appointments_controller')
require_relative('helpers')

get '/' do
  erb( :index )
end