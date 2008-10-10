require File.join(File.dirname(__FILE__), "..", "test_helper")

class MissingTablesFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  Pair = ActiveRecord::Lint::Pair
  
  def setup
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    ActiveRecord::Lint::load_models(@rails_root)
    super
    @connection.drop_table :criminals
  end
  
  def test_should_not_error_because_we_have_no_criminals_table
    missing_indexes = ActiveRecord::Lint::Scanner.new(@connection).missing_indexes
    
    assert_array_equal [Pair["incidents", "criminal_id"], Pair["incidents", "crime_id"]], missing_indexes
  end

  def test_should_report_lack_of_criminals_table
    missing_tables = ActiveRecord::Lint::Scanner.new(@connection).missing_tables
    
    assert_array_equal ["criminals"], missing_tables
  end
  
end
