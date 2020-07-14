require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/product')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

class TestProduct < MiniTest::Test

    def setup()
        @product_1 = Product.new({
            'name' => "Flea cream",
            'curr_price' => 9.99
        })
        @product_2 = Product.new({
            'name' => "Pet shampoo",
            'curr_price' => 10.99
        })
    end

    def test_has_name()
        assert_equal("Flea cream", @product_1.name)
    end

    def test_has_price()
        assert_equal(10.99, @product_2.curr_price)
    end

end