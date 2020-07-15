require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/owner_product' )
also_reload( '../models/*' )

# INDEX
get '/owner_products' do
    @owner_products = OwnerProduct.all
    erb ( :"owner_products/index" )
end

# NEW
get '/owner_products/new' do
    erb ( :"owner_products/new" )
end

# CREATE
post '/owner_products' do
    @owner_product = OwnerProduct.new(params)
    @owner_product.save()
    redirect to '/owner_products'
end

# DESTROY
post '/owner_products/:id/delete' do
    @owner_product = OwnerProduct.find(params['id'])
    @owner_product.delete()
    redirect to '/owner_products'
end