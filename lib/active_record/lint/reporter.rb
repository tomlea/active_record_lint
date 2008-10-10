require File.join(File.dirname(__FILE__), "pairs")

module ActiveRecord::Lint
  class MissingIndex < TableIndexPair
  end
  
  class MissingTable
    include Comparable
    attr_reader :table
    
    def initialize(table)
      @table=table
    end
    
    def <=> (other)
      table <=> other.table
    end
  end

  class MissingForeignKey < TableKeyPair
  end


  class Reporter
    SUMMARY_NAMES = ["missing_indexes", "missing_tables", "missing_foreign_keys"]

    def initialize(scanner)
      @scanner = scanner
    end
    
    def missing_indexes
      @scanner.missing_indexes.map{|pair| MissingIndex[*pair.to_ary] }
    end
    
    def missing_tables
      @scanner.missing_tables.map{|table| MissingTable.new(table) }
    end
    
    def missing_foreign_keys
      @scanner.missing_foreign_keys.map{|pair| MissingForeignKey[*pair.to_ary] }
    end
    
    def issues
      SUMMARY_NAMES.map{|name| send(name) }.sum
    end

    private
    attr_writer *SUMMARY_NAMES
  end
end

