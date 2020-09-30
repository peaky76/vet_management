require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/vet' )

# INDEX
get '/vets' do
    @vets = Vet.all
    erb ( :"vets/index" )
end

# NEW
get '/vets/new' do
    erb ( :"vets/new" )
end

# CREATE
post '/vets' do
    @vet = Vet.new(params)
    @vet.save()
    erb ( :"vets/create" )
end

# SHOW
get '/vets/:id' do
    @vet = Vet.find(params['id'])
    @start_date = Date.today()
    @start_date = Date.parse(params['start_date']) if params['start_date']
    erb ( :"vets/show" )    
end

# EDIT
get '/vets/:id/edit' do
    @vet = Vet.find(params['id'])
    erb ( :"vets/edit" )
end

# UPDATE
post '/vets/:id' do
    @vet = Vet.new(params)
    @vet.update()
    redirect to '/vets'  
end

# DESTROY
post '/vets/:id/delete' do
    @vet = Vet.new(params)
    # Remove pets from vet's list, ready to be reassigned, otherwise cannot delete from database
    for pet in @vet.pets
        pet.unassign()
        pet.update()
    end
    @vet.delete()
    redirect to '/vets'
end
