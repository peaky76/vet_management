require_relative( '../db/sql_runner' )

class PetTreatment

    attr_reader :id, :pet_id, :treatment_id, :cost, :date
    
    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @pet_id = options['pet_id'].to_i()
        @treatment_id = options['treatment_id'].to_i()
        # If no cost is given for the treatment, use the current price for this kind of treatment
        options['cost'] != nil ? @cost = options['cost'].to_f() : @cost = self.curr_price
        @date = Date.parse(options['date'])
    end

    # Instance methods
    
    def curr_price()
        return Treatment.find(@treatment_id).curr_price
    end

    def pretty_date()
        return @date.strftime("%-d %B %Y")
    end

    def owner_id()
        return Pet.find(@pet_id).owner_id
    end

    def bill_to_owner()
        sql = "UPDATE owners 
        SET balance_due = balance_due + $1
        WHERE id = $2"
        values = [@cost, self.owner_id]
        SqlRunner.run(sql, values)
    end

    # CRUD methods

    def save()
        sql = "INSERT INTO pet_treatments
        (pet_id, treatment_id, cost, date) 
        VALUES ($1, $2, $3, $4)
        RETURNING id"
        values = [@pet_id, @treatment_id, @cost, @date]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i() 
        self.bill_to_owner()
    end

    def update()
        sql = "UPDATE pet_treatments
        SET (pet_id, treatment_id, cost, date) =
        ($1, $2, $3, $4)
        WHERE id = $5"
        values = [@pet_id, @treatment_id, @cost, @date, @id]
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
