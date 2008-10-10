require File.join(File.dirname(__FILE__), "..", "test_helper")

class MissingIndexesAssociationsFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  Pair = ActiveRecord::Lint::Pair
  def setup
    ActiveRecord::Lint::unload_models
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    super
  end
  
  def test_should_know_we_need_an_index_on_victims
    ActiveRecord::Lint::load_models(@rails_root)
    
    missing_indexes = ActiveRecord::Lint::Scanner.new(@connection).missing_indexes
    
    assert_array_equal [Pair["incidents", "criminal_id"], Pair["incidents", "crime_id"]], missing_indexes
  end

  def test_should_be_able_to_call_missing_indexes_on_module
    missing_indexes = ActiveRecord::Lint.missing_indexes(:rails_root => @rails_root)
    
    assert_array_equal [Pair["incidents", "criminal_id"], Pair["incidents", "crime_id"]], missing_indexes
  end
  
  def test_should_handle_inherited_models
    ActiveRecord::Lint::load_models(@rails_root)    
    
    my_model = Class.new(Incident)
    missing_indexes = ActiveRecord::Lint::Scanner.new(@connection).missing_indexes
    
    assert_array_equal [Pair["incidents", "criminal_id"], Pair["incidents", "crime_id"]], missing_indexes
  end
  
end
