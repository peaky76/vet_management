
class Surgery

    now = DateTime.now
    @opening_time = DateTime.new(now.year, now.month, now.day, 10, 0)
    @closing_time = DateTime.new(now.year, now.month, now.day, 15, 00)
    @lunch_start = DateTime.new(now.year, now.month, now.day, 12, 0)
    @lunch_end = DateTime.new(now.year, now.month, now.day, 13, 0)
    @appointment_length = 30

    class << self
        attr_accessor :opening_time, :closing_time, :lunch_start, :lunch_end, :appointment_length
    end

end