require_relative( '../db/sql_runner' )

class Pet

    attr_reader :id, :vet_id 
    attr_accessor :dob, :name, :type, :owner_name, :owner_tel, :notes    

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @dob = options['dob']
        @type = options['type']
        @owner_name = options['owner_name']
        @owner_tel = options['owner_tel']
        @notes = options['notes']
        @vet_id = options['vet_id'].to_i() if options['vet_id']
    end

    ## Instance methods

    # Properties

    def vet()
        sql = "SELECT * FROM vets
        WHERE id = $1"
        values = [@vet_id]
        return Vet.get(sql, values)
    end

    # CRUD methods

    def save()
        sql = "INSERT INTO pets
        (name, dob, type, owner_name, owner_tel, notes, vet_id) 
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING id"
        values = [@name, @dob, @type, @owner_name, @owner_tel, @notes, @vet_id]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE pets
        SET (name, dob, type, owner_name, owner_tel, notes, vet_id) =
        ($1, $2, $3, $4, $5, $6, $7)
        WHERE id = $8"
        values = [@name, @dob, @type, @owner_name, @owner_tel, @notes, @vet_id, @id]
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