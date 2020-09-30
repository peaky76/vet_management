require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?

require_relative( '../models/product' )

# INDEX
get '/products' do
    @products = Product.all
    erb ( :"products/index" )
end

# NEW
get '/products/new' do
    erb ( :"products/new" )
end

# CREATE
post '/products' do
    @product = Product.new(params)
    @product.save()
    redirect to '/products'
end

# SHOW
get '/products/:id' do
    @product = Product.find(params['id'])
    erb ( :"products/show" )    
end

# EDIT
get '/products/:id/edit' do
    @product = Product.find(params['id'])
    erb ( :"products/edit" )
end

# UPDATE
post '/products/:id' do
    @product = Product.new(params)
    @product.update()
    redirect to '/products'    
end

# DESTROY
post '/products/:id/delete' do
    @product = Product.new(params)
    @product.delete()
    redirect to '/products'
end