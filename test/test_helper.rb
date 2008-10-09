require 'test/unit'

require File.join(File.dirname(__FILE__), "..", "lib", "missing_indexes")

module CriminalDatabase
  def self.included(other)    
    other.with_temp_db do
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
end

class Test::Unit::TestCase
  def self.with_temp_db(&block)
    include TempDB    
    @schema = Proc.new(&block) if block_given?
  end
  
  module TempDB 
    DB_PATH = "/tmp/%s.sqlite3"
  
    def teardown_database!
      File.delete(DB_PATH % [self.class.name])
    end
  
    def setup_database!
      ActiveRecord::Base.establish_connection(
        :adapter => "sqlite3",
        :database => (DB_PATH % [self.class.name])
      )
      ActiveRecord::Base.logger = Logger.new(File.open("/dev/null", "w"))
      @connection = ActiveRecord::Base.connection
    end
  
    def load_schema!(&block)
      ActiveRecord::Schema.verbose = false
      if block_given?
        ActiveRecord::Schema.define(&block)
      else
        ActiveRecord::Schema.define(&self.class.class_eval{@schema})
      end
    end
  
    def teardown
      teardown_database!
    end
  
    def setup
      setup_database!
      load_schema!
    end
  end
  
  def assert_array_equal(expected, actual, *args)
    assert_equal(expected.sort, actual.sort, *args)
  end
  
end