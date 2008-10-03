require File.join(File.dirname(__FILE__), "..", "test_helper")

class MissingIndexesAssociationsFunctionalTest < Test::Unit::TestCase
  def test_should_know_we_need_an_index_on_victims
    rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")

    MissingIndexes::load_models(rails_root)
    
    missing_indexes = MissingIndexes::References.new(@connection).check
    
    assert_equal [:criminal_id, :crime_id], missing_indexes[:incidents]
    assert_equal [:incidents], missing_indexes.keys
  end
  

  
  with_temp_db do
    create_table :crimes do |t|
    end
    
    create_table :criminals do |t|
    end
      
    create_table :incidents do |t|
      t.references :criminal
      t.references :victim
      t.references :crime
    end
    
    add_index :incidents, :victim_id

    create_table :victims do |t|
    end
  end
end
