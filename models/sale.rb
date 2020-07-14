require_relative( '../db/sql_runner' )

class Sale

    attr_reader :id, :cost, :date
    
    def initialize(options)
        @id = options['id'].to_i() if options['id']
        # If no cost is given for the sales item, use the current price of the item
        options['cost'] != nil ? @cost = options['cost'].to_f() : @cost = self.curr_price
        @date = Date.parse(options['date'])        
    end

    # Instance methods

    def pretty_date()
        return @date.strftime("%-d %B %Y")
    end

    def description()
        return "Item"
    end

end