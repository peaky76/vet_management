require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/owner')
require_relative('../models/payment')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

class TestPayment < MiniTest::Test

    def setup()
        @owner_1 = Owner.new({
            'id' => 1,
            'title' => "Mr",
            'first_name' => "Al",
            'last_name' => "Sayshun",
            'addr_1' => "8 Bone Street",
            'addr_2' => "Dogville",
            'town_city' => "Edinburgh",
            'postcode' => "EH16 5AA",
            'balance_due' => 75.00,
            'email' => "alsayshun@pedigreechum.com",
            'tel' => "0131 556 7788"
        })
        @payment_1 = Payment.new({
            'owner_id' => 1,
            'amount' => 50.00,
            'date' => "14/7/2020"
        })
    end

    def test_has_amount()
        assert_equal(50.00, @payment_1.amount)
    end

    def test_has_date()
        assert_equal("14/7/2020", @payment_1.date)
    end

end