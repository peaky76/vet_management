require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/pet.rb' )
also_reload( '../models/*' )

# INDEX
get '/pets' do
    @pets = Pet.all
    erb ( :"pets/index" )
end

# SHOW
get '/pets/:id' do
    @pets    
end

# NEW
get '/pets/new' do
    
end

# CREATE
post '/pets' do
    
end

# EDIT
get '/pets/:id/edit' do

end

# UPDATE
post '/pets/:id' do
    
end

# DESTROY
post '/pets/:id/delete' do
    
end

 