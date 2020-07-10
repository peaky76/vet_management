require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/vet')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

class TestVet < MiniTest::Test

    def setup()
        @vet_1 = Vet.new({
            'first_name' => "Sue",
            'last_name' => "Ollogee",
            'tel' => "0131 765 4321"
        })
    end

    def test_has_first_name()
        assert_equal("Sue", @vet_1.first_name)
    end

    def test_has_last_name()
        assert_equal("Ollogee", @vet_1.last_name)
    end

    def test_has_tel()
        assert_equal("0131 765 4321", @vet_1.tel)
    end

    def test_has_full_name()
        assert_equal("Dr Sue Ollogee", @vet_1.full_name)
    end

end