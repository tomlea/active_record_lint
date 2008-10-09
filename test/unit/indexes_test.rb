require File.join(File.dirname(__FILE__), "..", "test_helper")

class IndexesUnitTest < Test::Unit::TestCase
  include CriminalDatabase
  include MissingIndexes
  
  def test_should_have_correct_indexes
    scanner = Scanner.new(@connection)
    assert_equal([Pair["incidents", "victim_id"]], scanner.indexes)
  end
  
end