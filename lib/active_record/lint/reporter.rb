require File.join(File.dirname(__FILE__), "pairs")

module ActiveRecord::Lint
  class MissingIndex < TableIndexPair
    def to_s
      "The foreign key '#{index}' is not indexed on '#{table}'."
    end
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

    def to_s
      "Expected the table '#{table}' to exist."
    end
  end

  class MissingForeignKey < TableKeyPair
    def to_s
      "Missing foreign key '#{key}' on '#{table}'."
    end
  end


  class Reporter
    include Memoize
    SUMMARY_NAMES = ["missing_indexes", "missing_tables", "missing_foreign_keys"]

    def initialize(scanner)
      @scanner = scanner
    end
    
    def missing_indexes
      @scanner.missing_indexes.map{|pair| MissingIndex[*pair.to_ary] }
    end
    memoize :missing_indexes
    
    def missing_tables
      tables = @scanner.missing_tables.map{|table_issue| MissingTable.new(table_issue) }
      if defined?(ActionController::Base) and ActionController::Base.session_store != :active_record_store
        tables.reject!{|table| table.table}
      end
      tables
    end
    memoize :missing_tables
    
    def missing_foreign_keys
      @scanner.missing_foreign_keys.map{|pair| MissingForeignKey[*pair.to_ary] }
    end
    memoize :missing_foreign_keys
    
    def issues
      SUMMARY_NAMES.map{|name| send(name) }.sum
    end


    def to_s
      lines = returning([]){|output|
        SUMMARY_NAMES.each do |name|
          issues = send(name)
          unless issues.empty?
            output << "== #{name} =="
            issues.each do |issue|
              output << "* #{issue}"
            end
          end
        end
      }
      if lines.empty?
        "No issues found"
      else
        lines.join("\n")
      end
    end

    private
    attr_writer *SUMMARY_NAMES
  end
end

