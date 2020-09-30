require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/appointment' )

# INDEX
get '/appointments' do
    @date = Date.today() 
    @date = Date.parse(params['date']) if params['date']
    erb ( :"appointments/index" )
end

# NEW
get '/appointments/new' do
    @pet = Pet.find(params['pet_id'])
    erb ( :"appointments/new" )
end

# CREATE
post '/appointments' do
    params['date_time'] = Appointment.find(params['id']).date_time
    @appointment = Appointment.new(params)
    @appointment.update()
    redirect to "/pets/#{params["pet_id"]}"
end

# UPDATE
post '/appointments/:id' do
    @appointment = Appointment.find(params['id'])
    @appointment.cancel()
    @appointment.update()
    redirect to "/pets/#{params['pet_id']}"   
end

# SETUP
get '/appointments/setup' do
    erb( :"appointments/setup" ) 
end

# GENERATE
post '/appointments/generate/:vet_id/:date' do
    @date = Date.parse(params['date']) if params['date']
    @vet_id = params['vet_id']
    schedule = Appointment.generate_schedule(@date, @vet_id)
    schedule.each { |appointment| appointment.save() }
    redirect to "/appointments?date=#{params['date']}"   
end
