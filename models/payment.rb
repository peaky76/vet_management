require_relative( '../db/sql_runner' )

class Payment

    attr_reader :id 
    attr_accessor :owner_id, :amount, :date   

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @owner_id = options['owner_id'].to_i()
        @amount = options['amount'].to_f()
        @date = Date.parse(options['date'])
    end

    # Instance methods
    
    def pretty_date()
        return @date.strftime("%-d %B %Y")
    end

    def take_from_owner()
        sql = "UPDATE owners 
        SET balance_due = balance_due - $1
        WHERE id = $2"
        values = [@amount, @owner_id]
        SqlRunner.run(sql, values)
    end

    # CRUD methods

    def save()
        self.take_from_owner()
        sql = "INSERT INTO payments
        (owner_id, amount, date) 
        VALUES ($1, $2, $3)
        RETURNING id"
        values = [@owner_id, @amount, @date]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()      
    end

    def update()
        sql = "UPDATE payments
        SET (owner_id, amount, date) =
        ($1, $2, $3)
        WHERE id = $4"
        values = [@owner_id, @amount, @date, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM payments
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM payments"
        return Payment.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM payments"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM payments
        WHERE id = $1"
        values = [id]
        return Payment.get(sql, values)
    end

    # Helper functions for db

    def self.get_all(sql, values = [])
        payment_data = SqlRunner.run(sql, values)
        return payment_data.map { |payment| Payment.new(payment) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end