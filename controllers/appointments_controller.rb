require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/timeslot.rb' )
also_reload( '../models/*' )

# INDEX
get '/timeslots' do
    @timeslots = Timeslot.all
    erb ( :"timeslots/index" )
end

# NEW
get '/timeslots/new' do
    erb ( :"timeslots/new" )
end

# CREATE
post '/timeslots' do
    @timeslot = Timeslot.new(params)
    @timeslot.save()
    redirect to '/timeslots'
end

# SHOW
get '/timeslots/:id' do
    @timeslot = Timeslot.find(params['id'])
    erb ( :"timeslots/show" )    
end

# EDIT
get '/timeslots/:id/edit' do
    @timeslot = Timeslot.find(params['id'])
    erb ( :"timeslots/edit" )
end

# UPDATE
post '/timeslots/:id' do
    @timeslot = Timeslot.new(params)
    @timeslot.update()
    redirect to '/timeslots'    
end

# DESTROY
post '/timeslots/:id/delete' do
    @timeslot = Timeslot.new(params)
    @timeslot.delete()
    redirect to '/timeslots'
end