require_relative( '../db/sql_runner' )

class Pet

    attr_reader :id, :dob, :name, :type, :owner_tel, :notes, :vet_id    

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @dob = options['dob']
        @name = options['name']
        @type = options['type']
        @owner_tel = options['owner_tel']
        @notes = options['notes']
        @vet_id = options['vet_id'].to_i
    end

end