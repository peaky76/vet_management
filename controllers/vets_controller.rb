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

# SHOW
get '/vets/:id' do
    @vet = Vet.find(params['id'])
    erb ( :"vets/show" )    
end

# NEW
get '/vets/new' do
    erb ( :"vets/new" )
end

# CREATE
post '/vets' do
    erb ( :"vets/create" )
end

# EDIT
get '/vets/:id/edit' do
    erb ( :"vets/edit" )
end

# UPDATE
post '/vets/:id' do
    erb ( :"vets/update" )    
end

# DESTROY
post '/vets/:id/delete' do
    erb ( :"vets/destroy" )
end