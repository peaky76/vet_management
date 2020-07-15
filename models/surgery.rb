
class Surgery

    @open = { 'hour' => 9, 'minute' => 0 }
    @close = { 'hour' => 16, 'minute' => 0 }
    @lunch_start = { 'hour' => 12, 'minute' => 0 } 
    @lunch_end = { 'hour' => 13, 'minute' => 30 }
    @closed_days = ["Saturday", "Sunday"]
    @appointment_length = 30

    class << self
        attr_accessor :open, :close, :lunch_start, :lunch_end, :closed_days, :appointment_length
    end

end