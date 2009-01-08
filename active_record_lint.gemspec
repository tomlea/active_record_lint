# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_record_lint}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Lea"]
  s.date = %q{2009-01-08}
  s.default_executable = %q{arlint}
  s.description = %q{A library to support the automatic checking for the doing of stupid things with ActiveRecord.}
  s.email = %q{commits@tomlea.co.uk}
  s.executables = ["arlint"]
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["Rakefile", "README.markdown", "lib/active_record/lint/memoize.rb", "lib/active_record/lint/pairs.rb", "lib/active_record/lint/reporter.rb", "lib/active_record/lint/scanner.rb", "lib/active_record/lint.rb", "lib/active_record_lint.rb", "test/fixtures/criminals/app/models/crime.rb", "test/fixtures/criminals/app/models/criminal.rb", "test/fixtures/criminals/app/models/incident.rb", "test/fixtures/criminals/app/models/victim.rb", "test/functional/missing_foreign_keys_test.rb", "test/functional/missing_indexes_test.rb", "test/functional/missing_tables_test.rb", "test/functional/reporter_test.rb", "test/test_helper.rb", "test/unit/indexes_test.rb", "test/unit/model_scanning_test.rb", "test/unit/pair_test.rb", "bin/arlint"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/cwninja/active_record_lint}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Rails tool to find foreign keys without indexes and other common issues.}
  s.test_files = ["test/functional/missing_foreign_keys_test.rb", "test/functional/missing_indexes_test.rb", "test/functional/missing_tables_test.rb", "test/functional/reporter_test.rb", "test/unit/indexes_test.rb", "test/unit/model_scanning_test.rb", "test/unit/pair_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
