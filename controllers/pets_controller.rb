require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?

require_relative( '../models/pet' )

# INDEX
get '/pets' do
    @pets = Pet.all
    erb ( :"pets/index" )
end

# NEW
get '/pets/new' do
    @owner_id = params['owner_id']
    erb ( :"pets/new" )
end

# CREATE
post '/pets' do
    @pet = Pet.new(params)
    @pet.save()
    redirect to "/owners/#{params['owner_id']}"
end

# SHOW
get '/pets/:id' do
    @pet = Pet.find(params['id'])
    erb ( :"pets/show" )    
end

# EDIT
get '/pets/:id/edit' do
    @vets = Vet.all()
    @pet = Pet.find(params['id'])
    erb ( :"pets/edit" )
end

# UPDATE
post '/pets/:id' do
    @pet = Pet.new(params)
    @pet.update()
    redirect to "/pets/#{params['id']}"
end

# DESTROY
post '/pets/:id/delete' do
    @pet = Pet.find(params['id'])
    @pet.delete()
    redirect to '/pets'
end


 