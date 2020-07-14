require_relative( '../db/sql_runner' )

class Timeslot

    attr_reader :id, :vet_id, :pet_id, :time_date 

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @vet_id = options['vet_id'] 
        @pet_id = options['pet_id'] if options['pet_id']
        @date_time = options['date_time']
    end

    # Instance methods

    def pretty_date()
        return @date_time.strftime("%-d %B %Y")
    end

    def pretty_time()
        return @date_time.strftime("%H:%M")
    end

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

    def is_available?()
        return @pet_id == nil
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

    def self.generate(date, vet_id)
        
        timeslots = []
        
        vet = Vet.find(vet_id)
        
        # Get surgery hours 
        open = Surgery.opening_time 
        close = Surgery.closing_time
        out = Surgery.lunch_start
        back = Surgery.lunch_end
        appt_len = Surgery.appointment_length

        # Prepare time vars based on date parameter supplied
        curr_time = DateTime.new(date.year, date.month, date.day, open.hour, open.minute)
        end_time = DateTime.new(date.year, date.month, date.day, close.hour, close.minute)
        lunch_start = DateTime.new(date.year, date.month, date.day, out.hour, out.minute)
        lunch_end = DateTime.new(date.year, date.month, date.day, back.hour, back.minute)

        # Add a new timeslot at fixed interval between open and close, avoiding lunch
        while curr_time < end_time do
            if curr_time < lunch_start || curr_time > lunch_end
                timeslots << Timeslot.new({
                    'date_time' => curr_time,
                    'vet_id' => vet_id
                })
            end
            curr_time += appt_len.minutes
        end
        
        return timeslots
    end

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