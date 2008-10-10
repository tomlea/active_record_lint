require File.join(File.dirname(__FILE__), "..", "test_helper")

class MissingIndexesAssociationsFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  
  def setup
    MissingIndexes::unload_models
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    super
  end
  
  def test_should_know_we_need_an_index_on_victims
    MissingIndexes::load_models(@rails_root)
    
    missing_indexes = MissingIndexes::Scanner.new(@connection).missing_indexes
    
    assert_array_equal ["criminal_id", "crime_id"], missing_indexes["incidents"]
    assert_equal ["incidents"], missing_indexes.keys
  end

  def test_should_be_able_to_call_missing_indexes_on_module
    missing_indexes = MissingIndexes.missing_indexes(:rails_root => @rails_root)
    
    assert_array_equal ["criminal_id", "crime_id"], missing_indexes["incidents"]
    assert_equal ["incidents"], missing_indexes.keys
  end
  
  def test_should_handle_inherited_models
    MissingIndexes::load_models(@rails_root)    
    
    my_model = Class.new(Incident)
    missing_indexes = MissingIndexes::Scanner.new(@connection).missing_indexes
    
    assert_array_equal ["criminal_id", "crime_id"], missing_indexes["incidents"]
    assert_equal ["incidents"], missing_indexes.keys    
  end
  
end
