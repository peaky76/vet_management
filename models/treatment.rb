require_relative( '../db/sql_runner' )

class Treatment

    attr_reader :id 
    attr_accessor :name, :cost    

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @cost = options['cost'].to_i()
    end

end
