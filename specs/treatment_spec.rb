require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/treatment')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

class TestTreatment < MiniTest::Test

    def setup()
        @treatment_1 = Treatment.new({
            'name' => "Neutering",
            'curr_price' => 50.00
        })
        @treatment_2 = Treatment.new({
            'name' => "Worming",
            'curr_price' => 25.00
        })
    end

    def test_has_name()
        assert_equal("Neutering", @treatment_1.name)
    end

    def test_has_price()
        assert_equal(25.00, @treatment_2.curr_price)
    end

end