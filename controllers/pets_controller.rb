require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/pet.rb' )
also_reload( '../models/*' )

# INDEX
get '/pets' do
    @pets = Pet.all
    erb ( :"pets/index" )
end

# SHOW
get '/pets/:id' do
    @pet = Pet.find(params['id'])
    erb ( :"pets/show" )    
end

# NEW
get '/pets/new' do
    erb ( :"pets/new" )
end

# CREATE
post '/pets' do
    erb ( :"pets/create" )
end

# EDIT
get '/pets/:id/edit' do
    erb ( :"pets/edit" )
end

# UPDATE
post '/pets/:id' do
    erb ( :"pets/update" )    
end

# DESTROY
post '/pets/:id/delete' do
    erb ( :"pets/destroy" )
end

 