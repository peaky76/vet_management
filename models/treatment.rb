require_relative( '../db/sql_runner' )

class Treatment

    attr_reader :id 
    attr_accessor :name, :cost    

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @cost = options['cost'].to_i()
    end

    # Instance methods
    
    # CRUD methods

     def save()
        sql = "INSERT INTO treatments
        (name, cost) 
        VALUES ($1, $2)
        RETURNING id"
        values = [@name, @cost]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE treatments
        SET (name, cost) =
        ($1, $2)
        WHERE id = $3"
        values = [@name, @cost, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM treatments
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end
    
end
