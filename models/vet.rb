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
        pet_data = SqlRunner.run(sql, values)
        return pet_data.map { |pet| Pet.new(pet) }
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
        vet_data = SqlRunner.run(sql)
        return vet_data.map { |vet| Vet.new(vet) }
    end

    def self.delete_all()
        sql = "DELETE FROM vets"
        SqlRunner.run(sql)
    end

end