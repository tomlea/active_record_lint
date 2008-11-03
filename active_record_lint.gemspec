Gem::Specification.new do |s|
  s.name     = "active_record_lint"
  s.version  = "0.0.2"
  s.date     = "2008-10-14"
  s.summary  = "Rails tool to find foreign keys without indexes and other common issues."
  s.email    = "projects@tomlea.co.uk"
  s.homepage = "http://github.com/cwninja/active_record_lint"
  s.description = "A library to support the automatic checking for the doing of stupid things with ActiveRecord."
  s.has_rdoc = false
  s.authors  = ["Tom Lea"]
  s.files    = [
    "active_record_lint.gemspec",
    "lib/active_record/lint/memoize.rb",
    "lib/active_record/lint/pairs.rb",
    "lib/active_record/lint/reporter.rb",
    "lib/active_record/lint/scanner.rb",
    "lib/active_record/lint.rb",
    "lib/active_record_lint.rb",
    "Rakefile",
    "README.markdown"
  ]
  s.executables = [
    "arlint"
  ]
  s.test_files = [
    "test/fixtures/criminals/app/models/crime.rb",
    "test/fixtures/criminals/app/models/criminal.rb",
    "test/fixtures/criminals/app/models/incident.rb",
    "test/fixtures/criminals/app/models/victim.rb",
    "test/functional/missing_foreign_keys_test.rb",
    "test/functional/missing_indexes_test.rb",
    "test/functional/missing_tables_test.rb",
    "test/functional/reporter_test.rb",
    "test/test_helper.rb",
    "test/unit/indexes_test.rb",
    "test/unit/model_scanning_test.rb",
    "test/unit/pair_test.rb"
  ]
end
