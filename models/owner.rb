require_relative( '../db/sql_runner' )

class Owner

    attr_reader :id, :balance
    attr_accessor :title, :first_name, :last_name, :addr_1, :addr_2, :town_city, :postcode, :email, :tel, :balance

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @title = options['title']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @addr_1 = options['addr_1']
        @addr_2 = options['addr_2']
        @town_city = options['town_city']
        @postcode = options['postcode']
        @email = options['email']
        @tel = options['tel']
        options['balance'] == nil ? @balance = 0 : @balance = options['balance']
        options['registered'] == nil ? @registered = true : @registered = make_boolean(options['registered'])
        options['marketing'] == nil ? @marketing = false : @marketing = make_boolean(options['marketing'])
    end

    ## Instance methods

    # Properties
    def full_address()
        return "#{@addr_1}, #{@addr_2}, #{town_city}, #{postcode}"
    end

    def full_name()
        return "#{@title} #{@first_name} #{@last_name}"
    end

    def pets()
        sql = "SELECT * FROM pets
        WHERE owner_id = $1"
        values = [@id]
        return Pet.get_all(sql, values)
    end

    # CRUD Methods

    def save()
        sql = "INSERT INTO owners
        (title, first_name, last_name, addr_1, addr_2, town_city, postcode, email, tel, balance, registered, marketing) 
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
        RETURNING id"
        values = [@title, @first_name, @last_name, @addr_1, @addr_2, @town_city, @postcode, @email, @tel,
        @balance, @registered, @marketing]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def update()
        sql = "UPDATE owners
        SET (title, first_name, last_name, addr_1, addr_2, town_city, postcode, email, tel, balance, registered, marketing) =
        ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
        WHERE id = $13"
        values = [@title, @first_name, @last_name, @addr_1, @addr_2, @town_city, @postcode, @email, @tel,
        @balance, @registered, @marketing, @id]        
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM owners
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Other instance methods
    def accepts_marketing?()
        return @marketing
    end

    def is_registered?()
        return @registered
    end

    def deregister()
        @registered = false
    end

    def opt_in()
        @marketing = true
    end

    def opt_out()
        @marketing = false
    end

    def register()
        @registered = true
    end

    ## Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM owners"
        return Owner.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM owners"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM owners
        WHERE id = $1"
        values = [id]
        return Owner.get(sql, values)
    end

    # Helper functions for db
    
    def self.get_all(sql, values = [])
        owner_data = SqlRunner.run(sql, values)
        return owner_data.map { |owner| Owner.new(owner) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()    
    end

    def make_boolean(input)
        return true if ["t", true, "yes", 1].include?(input) 
        return false if ["f", false, "no", 0].include?(input)
    end

end
