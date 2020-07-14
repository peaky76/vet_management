require_relative( '../db/sql_runner' )

class SalesItem

    attr_reader :id 
    attr_accessor :name, :curr_price   

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @curr_price = options['curr_price'].to_f
    end

end