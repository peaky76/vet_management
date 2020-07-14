
class ::Float
 
    def to_currency()
        return "£#{sprintf('%.2f', self)}"
    end

end