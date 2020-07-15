require_relative( '../db/sql_runner' )

class Vet

    attr_reader :id
    attr_accessor :first_name, :last_name, :tel, :day_off

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @tel = options['tel']
        @day_off = options['day_off'] 
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
        sql = "SELECT * FROM appointments
        WHERE vet_id = $1"
        values = [@id]
        schedule = Appointment.get_all(sql, values)
        sorted_schedule = schedule.sort_by { |appointment| appointment.date_time }
        return sorted_schedule
    end

    def future_schedule()
        return self.schedule.filter { |appointment| appointment.date_time > Time.now() } 
    end

    def today_schedule()
        return self.schedule.filter { |appointment| appointment.date_time.to_date == Date.today }
    end

    def current_appointment()
        return self.today_schedule.filter { 
            |appointment| 
            appointment.date_time < Time.now && 
            appointment.date_time + Surgery.appointment_length.minutes > Time.now
        }.first
    end

    # CRUD Methods

    def save()
        sql = "INSERT INTO vets
        (first_name, last_name, tel, day_off) 
        VALUES ($1, $2, $3, $4)
        RETURNING id"
        values = [@first_name, @last_name, @tel, @day_off]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
        sql = "UPDATE vets
        SET (first_name, last_name, tel, day_off) =
        ($1, $2, $3, $4)
        WHERE id = $5"
        values = [@first_name, @last_name, @tel, @day_off, @id]
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