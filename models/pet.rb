require_relative( '../db/sql_runner' )

class Pet

    attr_reader :id 
    attr_accessor :dob, :name, :type, :owner_tel, :notes, :vet_id    

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @dob = options['dob']
        @name = options['name']
        @type = options['type']
        @owner_tel = options['owner_tel']
        @notes = options['notes']
        @vet_id = options['vet_id'].to_i
    end

    # Instance methods

    # CRUD methods

    def save()
        sql = "INSERT INTO pets
        (dob, name, type, owner_tel, notes, vet_id) 
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING id"
        values = [@dob, @name, @type, @owner_tel, @notes, @vet_id]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
        sql = "UPDATE pets
        SET (dob, name, type, owner_tel, notes, vet_id) =
        ($1, $2, $3, $4, $5, $6)
        WHERE id = $7"
        values = [@dob, @name, @type, @owner_tel, @notes, @vet_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM pets
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM pets"
        pet_data = SqlRunner.run(sql)
        return pet_data.map { |pet| Pet.new(pet) }
    end

    def self.delete_all()
        sql = "DELETE FROM pets"
        SqlRunner.run(sql)
    end

end