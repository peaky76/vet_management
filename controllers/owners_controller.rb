require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/owner' )
also_reload( '../models/*' )

# INDEX
get '/owners' do
    @owners = Owner.all
    erb ( :"owners/index" )
end

# REGISTER
get '/owners/register' do
    @owners = Owner.all()
    erb( :"owners/registration" ) 
end

# NEW
get '/owners/new' do
    erb ( :"owners/new" )
end

# CREATE
post '/owners' do
    @owner = Owner.new(params)
    @owner.save()
    redirect to '/owners'
end

# SHOW
get '/owners/:id' do
    @owner = Owner.find(params['id'])
    erb ( :"owners/show" )    
end

# EDIT
get '/owners/:id/edit' do
    @owner = Owner.find(params['id'])
    erb ( :"owners/edit" )
end

# UPDATE
post '/owners/:id' do
    @owner = Owner.new(params)
    params['registered'] == "on" ? @owner.register() : @owner.deregister()
    params['marketing'] == "on" ? @owner.opt_in() : @owner.opt_out()
    @owner.update()
    redirect to '/owners'    
end

# DESTROY
post '/owners/:id/delete' do
    @owner = Owner.find(params['id'])
    # Delete pets, otherwise cannot delete from database
    for pet in @owner.pets
        for treatment in pet.treatments_given()
            treatment.delete()
        end
        pet.delete()
    end
    @owner.delete()
    redirect to '/owners' 
end
