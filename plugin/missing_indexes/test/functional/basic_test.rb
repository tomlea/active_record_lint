require File.join(File.dirname(__FILE__), "..", "test_helper")

class MissingIndexesBasicFunctionalTest < Test::Unit::TestCase

  def test_should_detect_bad_indexes_on_bad_things
    missing_indexes = run_check!
    assert_equal([:bad_person_id, :victim_id], missing_indexes[:bad_things])
  end
  
  def test_should_not_detect_column_with_index_on_victims
    missing_indexes = run_check!
    assert(!missing_indexes.keys.include?(:victims), "Victims have a killer, but it's indexed... so it should not be flagged up.")
  end

  def test_should_not_detect_column_with_index_on_victims_tribunal_but_should_detect_other_missing_indexes
    missing_indexes = run_check!
    assert_equal [:victim_id], missing_indexes[:victims_tribunals]
  end
  
  def run_check!
    MissingIndexes::Basic.new(@connection).check
  end
  

  with_temp_db do
    create_table :bad_people do |t|
    end
  
    create_table :bad_things do |t|
      t.references :bad_person
      t.references :victim
    end
  
    create_table :victims do |t|
      t.references :killer
    end
    add_index :victims, :killer_id
  
    create_table :victims_tribunals do |t|
      t.references :bad_person
      t.references :victim
    end  
    add_index :victims_tribunals, :bad_person_id
  end
end
