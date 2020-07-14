require_relative( '../db/sql_runner' )

class Purchase

    attr_reader :id, :owner_id, :product_id, :cost, :date
    
    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @owner_id = options['owner_id'].to_i()
        @product_id = options['product_id'].to_i()
        # If no cost is given, use the current price for this kind of product
        options['cost'] != nil ? @cost = options['cost'].to_f() : @cost = self.curr_price
        @date = Date.parse(options['date'])
    end

    # Instance methods
    
    def curr_price()
        return Product.find(@product_id).curr_price
    end

    def pretty_date()
        return @date.strftime("%-d %B %Y")
    end

    def bill_to_owner()
        sql = "UPDATE owners 
        SET balance_due = balance_due + $1
        WHERE id = $2"
        values = [@cost, @owner_id]
        SqlRunner.run(sql, values)
    end

    # CRUD methods

    def save()
        sql = "INSERT INTO purchases
        (owner_id, product_id, cost, date) 
        VALUES ($1, $2, $3, $4)
        RETURNING id"
        values = [@owner_id, @product_id, @cost, @date]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i() 
        self.bill_to_owner()
    end

    def update()
        sql = "UPDATE purchases
        SET (owner_id, product_id, cost, date) =
        ($1, $2, $3, $4)
        WHERE id = $5"
        values = [@owner_id, @product_id, @cost, @date, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM purchases
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM purchases"
        return Purchase.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM purchases"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM purchases
        WHERE id = $1"
        values = [id]
        return Purchase.get(sql, values)
    end

    # Helper functions for db

    def self.get_all(sql, values = [])
        purchase_data = SqlRunner.run(sql, values)
        return purchase_data.map { |purchase| Purchase.new(purchase) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end
