require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/pet_treatment' )

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

# DESTROY
post '/pet_treatments/:id/delete' do
    @pet_treatment = PetTreatment.find(params['id'])
    @pet_treatment.delete()
    redirect to '/pet_treatments'
end




