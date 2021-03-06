require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/appointment')
require_relative('../models/pet')
require_relative('../models/vet')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

class Testappointment < MiniTest::Test

    def setup()
        @pet_1 = Pet.new({
            'id' => 1,
            'name' => "Rover",
            'dob' => "1/4/2015",
            'type' => "dog",
            'owner_name' => "Al Sayshun",
            'owner_tel' => "0131 123 4567",
            'notes' => "Has arthritis"
        })
        @vet_1 = Vet.new({
            'id' => 1,
            'first_name' => "Sue",
            'last_name' => "Ollogee",
            'tel' => "0131 765 4321"
        })
        @appointment_1 = Appointment.new({
            'vet_id' => @vet_1.id,
            'pet_id' => @pet_1.id,
            'date_time' => "13/7/2020 11:15"
        })
        @appointment_2 = Appointment.new({
            'vet_id' => @vet_1.id,
            'date_time' => "13/7/2020 11:45"
        })
    end

    def test_has_vet()
        assert_equal("Dr Sue Ollogee", @appointment_1.vet.full_name)
    end

    def test_has_price()
        assert_equal("Rover", @appointment_1.pet.name)
    end

    def test_has_pretty_date()
        assert_equal("13 July 2020", @appointment_1.pretty_date)
    end

    def test_has_pretty_time()
        assert_equal("11:15", @appointment_1.pretty_time)
    end


    def test_is_available_true()
        assert(@appointment_2.is_available?())
    end
    
    def test_is_available_false()
        refute(@appointment_1.is_available?())
    end

end