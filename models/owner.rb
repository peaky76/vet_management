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
        @balance = 0
        @registered = true
        @marketing = false
    end

     ## Instance methods

    # Properties
    def full_address()
        return "#{@addr_1}, #{@addr_2}, #{town_city}, #{postcode}"
    end

    def full_name()
        return "#{@title} #{@first_name} #{@last_name}"
    end

    # CRUD Methods



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

end
