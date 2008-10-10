require File.join(File.dirname(__FILE__), "..", "test_helper")

class ModelScanningUnitTest < Test::Unit::TestCase
  include CriminalDatabase
  include ActiveRecord::Lint

  def setup
    ActiveRecord::Lint::unload_models
    super
  end
  
  def test_should_have_correct_indexes    
    rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    ActiveRecord::Lint::load_models(rails_root)
    
    scanner = ActiveRecord::Lint::Scanner.new
    
    expected = [
      Pair["incidents", "victim_id"],
      Pair["incidents", "criminal_id"],
      Pair["incidents", "crime_id"]
    ]
    
    assert_array_equal(expected, scanner.foreign_keys)
  end
  
end