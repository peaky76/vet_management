require_relative( '../db/sql_runner' )

class PetTreatment

    attr_reader :id, :pet_id, :treatment_id, :date
    
    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @pet_id = options['pet_id'].to_i()
        @treatment_id = options['treatment_id'].to_i()
        @date = options['date']
    end

    # Instance methods
    
    # CRUD methods

    def save()
        sql = "INSERT INTO pet_treatments
        (pet_id, treatment_id, date) 
        VALUES ($1, $2, $3)
        RETURNING id"
        values = [@pet_id, @treatment_id, @date]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE pet_treatments
        SET (pet_id, treatment_id, date) =
        ($1, $2, $3)
        WHERE id = $4"
        values = [@pet_id, @treatment_id, @date, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM pet_treatments
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM pet_treatments"
        return PetTreatment.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM pet_treatments"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM pet_treatments
        WHERE id = $1"
        values = [id]
        return PetTreatment.get(sql, values)
    end

    # Helper functions for db

    def self.get_all(sql, values = [])
        pet_treatment_data = SqlRunner.run(sql, values)
        return pet_treatment_data.map { |pet_treatment| PetTreatment.new(pet_treatment) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end
