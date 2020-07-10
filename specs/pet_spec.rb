require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/pet')
require_relative('../models/vet')

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
        @vet_1 = Vet.new({
            'id' => 1,
            'first_name' => "Sue",
            'last_name' => "Ollogee",
            'tel' => "0131 765 4321"
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

    def test_assign_to_vet()
        @pet_1.assign_to_vet(@vet_1.id)
        assert_equal(1, @pet_1.vet_id)
    end

    def test_is_assigned_true()
        @pet_1.assign_to_vet(@vet_1.id)
        assert(@pet_1.is_assigned?())
    end

    def test_is_assigned_false()
        refute(@pet_1.is_assigned?())
    end

end