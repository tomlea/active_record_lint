require File.join(File.dirname(__FILE__), "..", "test_helper")

class MissingForeignKeysFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  include ActiveRecord::Lint
  
  def setup
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    ActiveRecord::Lint::load_models(@rails_root)
    super
    @connection.remove_column :incidents, :criminal_id
  end
  
  def test_should_not_error_because_we_are_missing_criminal_id
    missing_indexes = ActiveRecord::Lint::Scanner.new(@connection).missing_indexes
    
    assert_array_equal [Pair["incidents", "criminal_id"], Pair["incidents", "crime_id"]], missing_indexes
  end

  def test_should_report_lack_of_criminal_id_on_incidents_table
    missing_foreign_keys = ActiveRecord::Lint::Scanner.new(@connection).missing_foreign_keys
    
    assert_array_equal [Pair["incidents", "criminal_id"]], missing_foreign_keys
  end
  
end
