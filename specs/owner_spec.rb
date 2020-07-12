require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/owner')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new()

class TestOwner < MiniTest::Test

    def setup()
        @owner_1 = Owner.new({
            'title' => "Mr",
            'first_name' => "Al",
            'last_name' => "Sayshun",
            'addr_1' => "8 Bone Street",
            'addr_2' => "Dogville",
            'town_city' => "Edinburgh",
            'postcode' => "EH16 5AA",
            'email' => "alsayshun@pedigreechum.com",
            'tel' => "0131 556 7788"
        })
    end

    def test_has_title()
        assert_equal("Mr", @owner_1.title)
    end

    def test_has_first_name()
        assert_equal("Al", @owner_1.first_name)
    end

    def test_has_last_name()
        assert_equal("Sayshun", @owner_1.last_name)
    end

    def test_has_full_name()
        assert_equal("Mr Al Sayshun", @owner_1.full_name)
    end

    def test_has_addr_1()
        assert_equal("8 Bone Street", @owner_1.addr_1)
    end

    def test_has_addr_2()
        assert_equal("Dogville", @owner_1.addr_2)
    end

    def test_has_town_city()
        assert_equal("Edinburgh", @owner_1.town_city)
    end

    def test_has_postcode()
        assert_equal("EH16 5AA", @owner_1.postcode)
    end

    def test_has_full_address()
        assert_equal("8 Bone Street, Dogville, Edinburgh, EH16 5AA", @owner_1.full_address)
    end

    def test_has_email()
        assert_equal("alsayshun@pedigreechum.com", @owner_1.email)
    end

    def test_has_tel()
        assert_equal("0131 556 7788", @owner_1.tel)
    end

    def test_balance()
        assert_equal(0, @owner_1.balance)
    end

    def test_is_registered_true_start()
        assert(@owner_1.is_registered?())
    end

    def test_is_registered_false()
        @owner_1.deregister()
        refute(@owner_1.is_registered?())
    end

    def test_is_registered_again()
        @owner_1.deregister()
        @owner_1.register()
        assert(@owner_1.is_registered?())
    end

    def test_accepts_marketing_false()
        refute(@owner_1.accepts_marketing?())
    end

    def test_accepts_marketing_true()
        @owner_1.opt_in()
        assert(@owner_1.accepts_marketing?())
    end

    def test_declines_marketing_again()
        @owner_1.opt_in()
        @owner_1.opt_out()
        refute(@owner_1.accepts_marketing?())
    end

end