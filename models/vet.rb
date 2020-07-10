require_relative( '../db/sql_runner' )

class Vet

    attr_reader :id, :first_name, :last_name, :tel

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @tel = options['tel']
    end

    # Instance Methods
    
    def full_name()
        return "Dr #{@first_name} #{@last_name}"
    end

end