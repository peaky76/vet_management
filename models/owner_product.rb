require_relative( '../db/sql_runner' )
require_relative( 'sale' )

class OwnerProduct < Sale

    attr_reader :owner_id, :product_id
    
    def initialize(options)
        @owner_id = options['owner_id'].to_i()
        @product_id = options['product_id'].to_i()
        super(options)
    end

    # Instance methods
    
    def curr_price()
        return Product.find(@product_id).curr_price
    end

    def owner()
        return Owner.find(@owner_id)
    end

    def product()
        return Product.find(@product_id)
    end

    def description()
        return self.product.name
    end

    def bill_to_owner()
        sql = "UPDATE owners 
        SET balance_due = balance_due + $1
        WHERE id = $2"
        values = [@cost, @owner_id]
        SqlRunner.run(sql, values)
    end
    
    def unbill_owner()
        sql = "UPDATE owners 
        SET balance_due = balance_due - $1
        WHERE id = $2"
        values = [@cost, @owner_id]
        SqlRunner.run(sql, values)
    end

    # CRUD methods

    def save()
        sql = "INSERT INTO owner_products
        (owner_id, product_id, cost, date) 
        VALUES ($1, $2, $3, $4)
        RETURNING id"
        values = [@owner_id, @product_id, @cost, @date]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i() 
        self.bill_to_owner()
    end

    def update()
        sql = "UPDATE owner_products
        SET (owner_id, product_id, cost, date) =
        ($1, $2, $3, $4)
        WHERE id = $5"
        values = [@owner_id, @product_id, @cost, @date, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM owner_products
        WHERE id = $1"
        values = [@id]
        self.unbill_owner()
        SqlRunner.run(sql, values)
    end

    # Class methods

    # CRUD methods

    def self.all()
        sql = "SELECT * FROM owner_products"
        return OwnerProduct.get_all(sql)
    end

    def self.delete_all()
        sql = "DELETE FROM owner_products"
        SqlRunner.run(sql)
    end

    def self.find(id)
        sql = "SELECT * FROM owner_products
        WHERE id = $1"
        values = [id]
        return OwnerProduct.get(sql, values)
    end

    # Helper functions for db

    def self.get_all(sql, values = [])
        owner_product_data = SqlRunner.run(sql, values)
        return owner_product_data.map { |purchase| OwnerProduct.new(purchase) }
    end

    def self.get(sql, values = [])
        return self.get_all(sql, values).first()
    end

end
