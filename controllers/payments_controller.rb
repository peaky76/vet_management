require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/payment' )
also_reload( '../models/*' )

# INDEX
get '/payments' do
    @payments = Payment.all
    erb ( :"payments/index" )
end

# REGISTER
get '/payments/register' do
    @payments = Payment.all()
    erb( :"payments/registration" ) 
end

# NEW
get '/payments/new' do
    erb ( :"payments/new" )
end

# CREATE
post '/payments' do
    @payment = Payment.new(params)
    @payment.save()
    redirect to '/payments'
end

# SHOW
get '/payments/:id' do
    @payment = Payment.find(params['id'])
    erb ( :"payments/show" )    
end

# EDIT
get '/payments/:id/edit' do
    @payment = Payment.find(params['id'])
    erb ( :"payments/edit" )
end