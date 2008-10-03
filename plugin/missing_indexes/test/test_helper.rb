require 'test/unit'
require 'rubygems'
require 'active_record'

require File.join(File.dirname(__FILE__), "..", "lib", "missing_indexes")


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
end