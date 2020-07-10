require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/vet.rb' )
also_reload( '../models/*' )

# INDEX
get '/vets' do
    @vets = Vet.all
    erb ( :"vets/index" )
end