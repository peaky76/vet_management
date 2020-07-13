require_relative( '../db/sql_runner' )

class Treatment

    attr_reader :id 
    attr_accessor :name, :curr_price   

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @curr_price = options['curr_price'].to_f
    end

    # Instance methods
    
    # CRUD methods

     def save()
        sql = "INSERT INTO treatments
        (name, curr_price) 
        VALUES ($1, $2)
        RETURNING id"
        values = [@name, @curr_price]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE treatments
        SET (name, curr_price) =
        ($1, $2)
        WHERE id = $3"
        values = [@name, @curr_price, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM treatments
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM treatments"
        return Treatment.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM treatments"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM treatments
        WHERE id = $1"
        values = [id]
        return Treatment.get(sql, values)
    end

    # Helper functions for db

    def self.get_all(sql, values = [])
        treatment_data = SqlRunner.run(sql, values)
        return treatment_data.map { |treatment| Treatment.new(treatment) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end
