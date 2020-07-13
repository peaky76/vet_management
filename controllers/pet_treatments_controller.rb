require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/pet_treatment.rb' )
also_reload( '../models/*' )

# INDEX
get '/pet_treatments' do
    @pet_treatments = PetTreatment.all
    erb ( :"pet_treatments/index" )
end

# NEW
get '/pet_treatments/new' do
    @pet = Pet.find(params['pet_id'])
    erb ( :"pet_treatments/new" )
end

# CREATE
post '/pet_treatments' do
    @pet_treatment = PetTreatment.new(params)
    @pet_treatment.save()
    redirect to "/pets/#{params["pet_id"]}"
end

# SHOW
get '/pet_treatments/:id' do
    @pet_treatment = PetTreatment.find(params['id'])
    erb ( :"pet_treatments/show" )    
end

# EDIT
get '/pet_treatments/:id/edit' do
    @pet_treatment = PetTreatment.find(params['id'])
    erb ( :"pet_treatments/edit" )
end

# UPDATE
post '/pet_treatments/:id' do
    @pet_treatment = PetTreatment.new(params)
    @pet_treatment.update()
    erb ( :"pet_treatments/update" )    
end

# DESTROY
post '/pet_treatments/:id/delete' do
    @pet_treatment = PetTreatment.new(params)
    @pet_treatment.delete()
    erb ( :"pet_treatments/destroy" )
end