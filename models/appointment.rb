require_relative( '../db/sql_runner' )

class Appointment

    attr_reader :id, :vet_id, :pet_id, :date_time 

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @vet_id = options['vet_id'] 
        @pet_id = options['pet_id'] if options['pet_id']
        @date_time = Time.parse(options['date_time'].to_s)
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

    def cancel()
        @pet_id = nil
    end

    def is_available?()
        return @pet_id == nil
    end

    def is_past?()
        return @date_time >= Date.today()
    end
    
    # CRUD methods

     def save()
        sql = "INSERT INTO appointments
        (vet_id, pet_id, date_time) 
        VALUES ($1, $2, $3)
        RETURNING id"
        values = [@vet_id, @pet_id, @date_time]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE appointments
        SET (vet_id, pet_id, date_time) =
        ($1, $2, $3)
        WHERE id = $4"
        values = [@vet_id, @pet_id, @date_time, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM appointments
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    def self.generate_schedule(date_start, date_end, vet_id)
        
        appointments = []
        appt_len = Surgery.appointment_length
        vet = Vet.find(vet_id)
 
        curr_date = date_start

        # Loop through days from start to end
        while curr_date < date_end do
 
            # Simple variables for date elements
            y = curr_date.year 
            m = curr_date.month 
            d = curr_date.day 
            dow = curr_date.strftime("%A")

            unless Surgery.closed_days.include?(dow) || vet.days_off.include?(dow)
                
                # Prepare time vars based on date parameter supplied
                curr_time = DateTime.new(y, m, d, Surgery.open['hour'], Surgery.open['minute'])
                end_time = DateTime.new(y, m, d, Surgery.close['hour'], Surgery.close['minute'])
                lunch_start = DateTime.new(y, m, d, Surgery.lunch_start['hour'], Surgery.lunch_start['minute'])
                lunch_end = DateTime.new(y, m, d, Surgery.lunch_end['hour'], Surgery.lunch_end['minute'])

                # Add a new appointment at fixed interval between open and close, avoiding lunch
                while curr_time < end_time do
                    if curr_time < lunch_start || curr_time > lunch_end
                        appointments << Appointment.new({
                            'date_time' => curr_time.to_s,
                            'vet_id' => vet_id
                        })
                    end
                    curr_time += appt_len.minutes
                end

            end

            curr_date += 1.day

        end

        return appointments
    end

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM appointments"
        return Appointment.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM appointments"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM appointments
        WHERE id = $1"
        values = [id]
        return Appointment.get(sql, values)
    end

    # Helper functions for db

    def self.get_all(sql, values = [])
        appointment_data = SqlRunner.run(sql, values)
        return appointment_data.map { |appointment| Appointment.new(appointment) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end