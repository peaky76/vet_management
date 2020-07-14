require('time_difference')

require_relative( '../db/sql_runner' )

class Pet

    attr_reader :id, :vet_id, :owner_id 
    attr_accessor :dob, :name, :type, :notes    

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @dob = Date.parse(options['dob'])
        @type = options['type']
        @notes = options['notes']
        @owner_id = options['owner_id'].to_i() if options['owner_id']
        @vet_id = options['vet_id'].to_i() if options['vet_id']
    end

    ## Instance methods

    # Properties

    def age()
        age = TimeDifference.between(Date.today, @dob).in_years.floor
        return "#{age} years old" if age >= 1
        age = TimeDifference.between(Date.today, @dob).in_months.floor
        return "#{age} months old"
    end

    def pretty_dob()
        return @dob.strftime("%-d %B %Y")
    end

    def owner()
        sql = "SELECT * FROM owners
        WHERE id = $1"
        values = [@owner_id]
        return Owner.get(sql, values)
    end

    def vet()
        sql = "SELECT * FROM vets
        WHERE id = $1"
        values = [@vet_id]
        return Vet.get(sql, values)
    end

    def ownership()
        if owner()
            return "Owner: #{self.owner.full_name}" if owner()
        else
            return "Not owned by anyone"
        end
    end

    def status()
        if self.is_assigned?
            status = "Assigned to: #{self.vet.full_name}"
        else
            status = "Not assigned to vet"
        end
        return status
    end

    def appointments()
        sql = "SELECT * FROM appointments
        WHERE pet_id = $1"
        values =[@id]
        return Appointment.get_all(sql, values)
    end

    def treatments_given()
        sql = "SELECT * FROM pet_treatments
        WHERE pet_id = $1"
        values = [@id]
        return PetTreatment.get_all(sql, values)
    end


    # CRUD methods

    def save()
        sql = "INSERT INTO pets
        (name, dob, type, notes, owner_id, vet_id) 
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING id"
        values = [@name, @dob, @type, @notes, @owner_id, @vet_id]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE pets
        SET (name, dob, type, notes, owner_id, vet_id) =
        ($1, $2, $3, $4, $5, $6)
        WHERE id = $7"
        values = [@name, @dob, @type, @notes, @owner_id, @vet_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM pets
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Other instance methods

    def assign_to_vet(vet_id)
        @vet_id = vet_id
    end

    def unassign()
        @vet_id = nil
    end

    def is_assigned?()
        return vet_id != nil
    end

    ## Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM pets"
        return Pet.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM pets"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM pets
        WHERE id = $1"
        values = [id]
        return Pet.get(sql, values)
    end

    # Helper functions for db
    
    def self.get_all(sql, values = [])
        pet_data = SqlRunner.run(sql, values)
        return pet_data.map { |pet| Pet.new(pet) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()    
    end

end