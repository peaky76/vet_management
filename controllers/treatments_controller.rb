require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/treatment.rb' )
also_reload( '../models/*' )

# INDEX
get '/treatments' do
    @treatments = Treatment.all
    erb ( :"treatments/index" )
end

# NEW
get '/treatments/new' do
    erb ( :"treatments/new" )
end

# CREATE
post '/treatments' do
    @treatment = Treatment.new(params)
    @treatment.save()
    erb ( :"treatments/create")
end

# SHOW
get '/treatments/:id' do
    @treatment = Treatment.find(params['id'])
    erb ( :"treatments/show" )    
end

# EDIT
get '/treatments/:id/edit' do
    @treatment = Treatment.find(params['id'])
    erb ( :"treatments/edit" )
end

# UPDATE
post '/treatments/:id' do
    @treatment = Treatment.new(params)
    @treatment.update()
    erb ( :"treatments/update" )    
end

# DESTROY
post '/treatments/:id/delete' do
    @treatment = Treatment.new(params)
    @treatment.delete()
    erb ( :"treatments/destroy" )
end