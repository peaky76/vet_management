require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/treatment' )
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
    redirect to '/treatments'
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
    redirect to '/treatments'    
end

# DESTROY
post '/treatments/:id/delete' do
    @treatment = Treatment.new(params)
    @treatment.delete()
    redirect to '/treatments'
end