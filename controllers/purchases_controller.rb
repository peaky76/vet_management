require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/purchase' )
also_reload( '../models/*' )

# INDEX
get '/purchases' do
    @purchases = Purchase.all
    erb ( :"purchases/index" )
end

# NEW
get '/purchases/new' do
    erb ( :"purchases/new" )
end

# CREATE
post '/purchases' do
    @purchase = Purchase.new(params)
    @purchase.save()
    redirect to '/purchases'
end