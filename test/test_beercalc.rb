require 'test/unit'
require 'beercalc'

class BeercalcTest < Test::Unit::TestCase
  def test_abv
    assert_equal 7.204999999999992, Beercalc.abv(1.055, 1)
    assert_equal nil, Beercalc.abv(1, 1.055)
    assert_equal nil, Beercalc.abv("asdf", "asdf")
  end

  def test_utilization
    assert_equal 0.08363227080582435, Beercalc.utilization(10, 1.050)
    assert_equal 0.30113013986478654, Beercalc.utilization(120, 1.030)
    assert_equal 0.0, Beercalc.utilization(0, 1.070)
    assert_equal 0.14780486892282785, Beercalc.utilization(45, 1.090)
    assert_equal nil, Beercalc.utilization(nil, nil)
    assert_equal nil, Beercalc.utilization("asdf", "asdf")
  end

  def test_mcu
    assert_equal nil, Beercalc.mcu(1, 1, 0)
    assert_equal nil, Beercalc.mcu(1, 1, nil)
    assert_equal nil, Beercalc.mcu(nil, 1, 1)
    assert_equal nil, Beercalc.mcu(1, nil, 1)
    assert_equal nil, Beercalc.mcu(nil, nil, nil)
    assert_equal 5, Beercalc.mcu(5, 5, 5)
    assert_equal 5.5, Beercalc.mcu(5.5, 5.5, 5.5)
  end

  def test_srm
    assert_equal nil, Beercalc.srm(nil, nil, nil)
    assert_equal nil, Beercalc.srm("asdf", nil, "asdf")
    assert_equal 5.668651803424155, Beercalc.srm(7,5,5)
    assert_equal 5.943353419684101, Beercalc.srm(7.5, 5.5, 5.5)
  end

  def test_aau
    assert_equal nil, Beercalc.aau(nil, 5)
    assert_equal nil, Beercalc.aau(4, nil)
    assert_equal nil, Beercalc.aau(nil, nil)
    assert_equal nil, Beercalc.aau("asdf", "asdf")
    assert_equal 9.600000000000001, Beercalc.aau(1.5, 6.4) # Based off Palmer's Calculation
    assert_equal 4.6, Beercalc.aau(1, 4.6) # Based off Palmer's Calculation
  end

  def test_ibu
    assert_equal 25.365869680614512, Beercalc.ibu(6.4, 1.5, 60, 1.080, 5) # Based off Palmer's Calculation
    assert_equal 6.03108750923272, Beercalc.ibu(4.6, 1, 15, 1.080, 5) # Based off Palmer's Calculation
    assert_equal nil, Beercalc.ibu(nil, 1, 15, 1.080, 5)
    assert_equal nil, Beercalc.ibu(nil, nil, 15, 1.080, 5)
    assert_equal nil, Beercalc.ibu(nil, nil, nil, 1.080, 5)
    assert_equal nil, Beercalc.ibu(nil, nil, nil, nil, 5)
    assert_equal nil, Beercalc.ibu(nil, nil, nil, 1.080, nil)
    assert_equal nil, Beercalc.ibu(4.6, 1, 15, 1.080, "asdf")
  end
end
