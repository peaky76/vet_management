
class ::Float
 
    def to_currency()
        return "£#{sprintf('%.2f', self)}"
    end

end

class ::Array

    def to_chron_order()
        return self.sort_by { |item| item.date } if self.all? { |item| item.instance_variable_defined?(:@date) }
        return self.sort_by { |item| item.date_time } if self.all? { |item| item.instance_variable_defined?(:@date_time) }
    end

end