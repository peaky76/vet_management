require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/pet')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

class TestPet < MiniTest::Test

    def setup()
        @pet_1 = Pet.new({
            'name' => "Rover",
            'dob' => "1/4/2015",
            'type' => "dog",
            'owner_tel' => "0131 123 4567",
            'notes' => "Has arthritis"
        })
    end

    def test_has_name()
        assert_equal("Rover", @pet_1.name)
    end

    def test_has_dob()
        assert_equal("1/4/2015", @pet_1.dob)
    end

    def test_has_type()
        assert_equal("dog", @pet_1.type)
    end

    def test_has_owner_tel()
        assert_equal("0131 123 4567", @pet_1.owner_tel)
    end

    def test_has_notes()
        assert_equal("Has arthritis", @pet_1.notes)
    end

end