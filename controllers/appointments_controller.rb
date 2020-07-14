require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

also_reload( '../models/*' )

# INDEX
get '/appointments' do
    erb ( :"appointments/index" )
end

# NEW
get '/appointments/new' do
    @pet = Pet.find(params['pet_id'])
    erb ( :"appointments/new" )
end

# CREATE
post '/appointments' do
    params['date_time'] = Timeslot.find(params['id']).date_time
    @timeslot = Timeslot.new(params)
    @timeslot.update()
    redirect to '/appointments'
end

# # SHOW
# get '/appointments/:id' do
#     erb ( :"appointments/show" )    
# end

# # EDIT
# get '/appointments/:id/edit' do
#     erb ( :"appointments/edit" )
# end

# # UPDATE
# post '/appointments/:id' do
#     redirect to '/appointments'    
# end

# # DESTROY
# post '/appointments/:id/delete' do
#     redirect to '/appointments'
# end