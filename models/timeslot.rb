require_relative( '../db/sql_runner' )

class Timeslot

    attr_reader :id, :vet_id, :pet_id, :time_date 

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @vet_id = options['vet_id']
        @pet_id = options['pet_id']
        @time_date = options['time_date']
    end

    # Instance methods

    def pet()
        sql = "SELECT * FROM pets
        WHERE id = $1"
        values = [@pet_id]
        return Pet.get(sql, values)
    end

    def vet()
        sql = "SELECT * FROM vets
        WHERE id = $1"
        values = [@vet_id]
        return Vet.get(sql, values)
    end
    
    # CRUD methods

     def save()
        sql = "INSERT INTO timeslots
        (vet_id, pet_id, time_date) 
        VALUES ($1, $2, $3)
        RETURNING id"
        values = [@vet_id, @pet_id, @time_date]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE timeslots
        SET (vet_id, pet_id, time_date) =
        ($1, $2, $3)
        WHERE id = $4"
        values = [@vet_id, @pet_id, @time_date, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM timeslots
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM timeslots"
        return Timeslot.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM timeslots"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM timeslots
        WHERE id = $1"
        values = [id]
        return Timeslot.get(sql, values)
    end

    # Helper functions for db

    def self.get_all(sql, values = [])
        timeslot_data = SqlRunner.run(sql, values)
        return timeslot_data.map { |timeslot| Timeslot.new(timeslot) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end