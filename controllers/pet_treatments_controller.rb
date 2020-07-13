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
    @pet_treatment.bill_to_owner()
    redirect to "/pets/#{params["pet_id"]}"
end
