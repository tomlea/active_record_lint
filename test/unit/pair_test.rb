require File.join(File.dirname(__FILE__), "..", "test_helper")

class PairUnitTest < Test::Unit::TestCase
  include MissingIndexes
  
  def test_comparison
    assert_equal(Pair[1,2], Pair[1,2])
    assert_equal(0, Pair[1,2] <=> Pair[1,2])
    assert_equal(-1, Pair[0,2] <=> Pair[1,2])
    assert_equal(1, Pair[2,2] <=> Pair[1,2])
    assert_equal(-1, Pair[1,1] <=> Pair[1,2])
    assert_equal(1, Pair[1,3] <=> Pair[1,2])
    
    assert_not_equal(Pair[1,2], Pair[1,3])
    assert_not_equal(Pair[1,2], Pair[2,2])
  end
  
  def test_subtraction_in_an_array
    a1 = [Pair[1,2], Pair[2,2], Pair[1,1]]
    a2 = [Pair[1,2], Pair[1,1]]
    a3 = [Pair[2,2]]

    assert_equal(a2, a1 - a3)
    assert_equal(a3, a1 - a2)
    assert_equal([], a1 - a2 - a3)
  end
  
  def test_hashes
    assert_equal(Pair[1,2].hash, Pair[1,2].hash)
    assert_equal(Pair[2,2].hash, Pair[2,2].hash)
    assert_not_equal(Pair[1,2].hash, Pair[1,1].hash)
    assert_not_equal(Pair[2,1].hash, Pair[1,1].hash)
  end
  
  def test_eql
    assert(Pair[2,2].eql?(Pair[2,2]))
  end
end