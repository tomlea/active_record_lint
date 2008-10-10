require File.join(File.dirname(__FILE__), "..", "test_helper")

class MissingTablesFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  
  def setup
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    ActiveRecord::Lint::load_models(@rails_root)
    super
    @connection.drop_table :criminals
  end
  
  def test_should_not_error_because_we_have_no_criminals_table
    missing_indexes = ActiveRecord::Lint::Scanner.new(@connection).missing_indexes
    
    assert_array_equal ["criminal_id", "crime_id"], missing_indexes["incidents"]
    assert_equal ["incidents"], missing_indexes.keys
  end

  def test_should_report_lack_of_criminals_table
    missing_tables = ActiveRecord::Lint::Scanner.new(@connection).missing_tables
    
    assert_array_equal ["criminals"], missing_tables
  end
  
end
