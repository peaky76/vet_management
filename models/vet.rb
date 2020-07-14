require_relative( '../db/sql_runner' )

class Vet

    attr_reader :id
    attr_accessor :first_name, :last_name, :tel

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @tel = options['tel']
    end

    # Instance Methods

    # Properties

    def full_name()
        return "Dr #{@first_name} #{@last_name}"
    end

    def pets()
        sql = "SELECT * FROM pets
        WHERE vet_id = $1"
        values = [@id]
        return Pet.get_all(sql, values)
    end

    def schedule()
        sql = "SELECT * FROM timeslots
        WHERE vet_id = $1"
        values = [@id]
        schedule = Timeslot.get_all(sql, values)
        sorted_schedule = schedule.sort_by { |timeslot| timeslot.date_time }
        return sorted_schedule
    end

    def future_schedule()
        return self.schedule.filter { |timeslot| timeslot.date_time.to_date >= Date.today() } 
    end


    # CRUD Methods

    def save()
        sql = "INSERT INTO vets
        (first_name, last_name, tel) 
        VALUES ($1, $2, $3)
        RETURNING id"
        values = [@first_name, @last_name, @tel]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
        sql = "UPDATE vets
        SET (first_name, last_name, tel) =
        ($1, $2, $3)
        WHERE id = $4"
        values = [@first_name, @last_name, @tel, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM vets
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM vets"
        return Vet.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM vets"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM vets
        WHERE id = $1"
        values = [id]
        return Vet.get(sql, values)
    end

     # Helper functions for db

     def self.get_all(sql, values = [])
        vet_data = SqlRunner.run(sql, values)
        return vet_data.map { |vet| Vet.new(vet) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end