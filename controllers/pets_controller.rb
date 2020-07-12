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

# NEW
get '/pets/new' do
    erb ( :"pets/new" )
end

# CREATE
post '/pets' do
    @pet = Pet.new(params)
    @pet.save()
    erb ( :"pets/create")
end

# SHOW
get '/pets/:id' do
    @pet = Pet.find(params['id'])
    erb ( :"pets/show" )    
end

# EDIT
get '/pets/:id/edit' do
    @pet = Pet.find(params['id'])
    erb ( :"pets/edit" )
end

# UPDATE
post '/pets/:id' do
    @pet = Pet.new(params)
    @pet.update()
    erb ( :"pets/update" )    
end

# DESTROY
post '/pets/:id/delete' do
    @pet = Pet.new(params)
    @pet.delete()
    erb ( :"pets/destroy" )
end

 