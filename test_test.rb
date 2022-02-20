require_relative 'test_main'
require 'minitest/autorun'

class Test < Minitest::Test
    def test_one
        paid_till = "04.07.2021"
        max_version = nil
        min_version = nil
        last_version = "21.10"
        license = License.new(paid_till, max_version, min_version)
        result = license.get_versions(last_version)
        assert_equal(["21.06", "21.07"], result, 'Test one failed.')
    end

    def test_two
        paid_till = "04.07.2020"
        max_version = "20.02"
        min_version = "19.01"
        last_version = "20.10"
        license = License.new(paid_till, max_version, min_version)
        result = license.get_versions(last_version)
        assert_equal(["20.02"], result, 'Test two failed.')
    end

    def test_three
        paid_till = "04.07.2022"
        max_version = "22.02"
        min_version = "19.01"
        last_version = "22.03"
        license = License.new(paid_till, max_version, min_version)
        result = license.get_versions(last_version)
        assert_equal(["21.11", "21.12", "22.01", "22.02"], result, 'Test three failed.')
    end

    def test_four
        paid_till = "02.07.2021"
        max_version = "22.01"
        min_version = "21.03"
        last_version = "21.12"
        license = License.new(paid_till, max_version, min_version)
        result = license.get_versions(last_version)
        assert_equal(["22.01"], result, 'Test four failed.')
    end

    def test_five
        paid_till = "08.01.22"
        max_version = "22.03"
        min_version = "21.12"
        last_version = "22.03"
        license = License.new(paid_till, max_version, min_version)
        result = license.get_versions(last_version)
        assert_equal(["21.12", "22.01"], result, 'Test five failed.')
    end

    def test_six
        paid_till = "22.12.21"
        max_version = "21.12"
        min_version = "21.01"
        last_version = "21.12"
        license = License.new(paid_till, max_version, min_version)
        result = license.get_versions(last_version)
        assert_equal(["21.08", "21.09", "21.10", "21.11", "21.12"], result, 'Test six failed.')
    end
end