require File.join(File.dirname(__FILE__), "..", "test_helper")

class ReporterMissingIndexesFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  Lint = ActiveRecord::Lint
  Pair = Lint::Pair
  
  def setup
    super
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    Lint::load_models(@rails_root)
  end
  
  def test_should_report_missing_indexes_on_incidents
    scanner = Lint::Scanner.new(@connection)
    reporter = Lint::Reporter.new(scanner)
    
    assert_array_includes Lint::MissingIndex["incidents", "crime_id"], Lint::MissingIndex["incidents", "criminal_id"], reporter.missing_indexes
  end

  def test_issues_should_report_missing_indexes_on_incidents
    scanner = Lint::Scanner.new(@connection)
    reporter = Lint::Reporter.new(scanner)
    
    assert_array_includes Lint::MissingIndex["incidents", "crime_id"], Lint::MissingIndex["incidents", "criminal_id"], reporter.issues
  end
  
end


class ReporterMissingTablesFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  Lint = ActiveRecord::Lint
  Pair = Lint::Pair
  
  def setup
    super
    @connection.drop_table :criminals
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    Lint::load_models(@rails_root)
  end
  
  def test_should_report_missing_table_criminals
    scanner = Lint::Scanner.new(@connection)
    reporter = Lint::Reporter.new(scanner)
    
    assert_array_includes Lint::MissingTable.new("criminals"), reporter.missing_tables
  end

  def test_issues_should_report_missing_table_criminals
    scanner = Lint::Scanner.new(@connection)
    reporter = Lint::Reporter.new(scanner)
    
    assert_array_includes Lint::MissingTable.new("criminals"), reporter.issues
  end
  
end

class ReporterMissingForeignKeysFunctionalTest < Test::Unit::TestCase
  include CriminalDatabase
  Lint = ActiveRecord::Lint
  Pair = Lint::Pair
  
  def setup
    super
    @connection.remove_column :incidents, :criminal_id
    @rails_root = File.join(File.dirname(__FILE__), "..", "fixtures", "criminals")
    Lint::load_models(@rails_root)
  end
  
  def test_should_report_missing_table_criminals
    scanner = Lint::Scanner.new(@connection)
    reporter = Lint::Reporter.new(scanner)
    
    assert_array_includes Lint::MissingForeignKey["incidents", "criminal_id"], reporter.missing_foreign_keys
  end

  def test_issues_should_report_missing_table_criminals
    scanner = Lint::Scanner.new(@connection)
    reporter = Lint::Reporter.new(scanner)
    
    assert_array_includes Lint::MissingForeignKey["incidents", "criminal_id"], reporter.issues
  end
  
end