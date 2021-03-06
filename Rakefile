require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'date'

desc 'Default: run unit tests.'
task :default => :test

namespace :test do
  desc 'Functional tests.'
  Rake::TestTask.new(:functional) do |t|
    t.libs << 'lib'
    t.pattern = 'test/functional/*_test.rb'
    t.verbose = true
  end
  desc 'Unit tests.'
  Rake::TestTask.new(:unit) do |t|
    t.libs << 'lib'
    t.pattern = 'test/unit/*_test.rb'
    t.verbose = true
  end
end

task :test => ["test:functional", "test:unit"]

spec = Gem::Specification.new do |s|
  s.name        = %q{active_record_lint}
  s.version     = "0.0.3"
  s.summary     = %q{Rails tool to find foreign keys without indexes and other common issues.}
  s.description = %q{A library to support the automatic checking for the doing of stupid things with ActiveRecord.}

  s.executables = ["arlint"]
  s.files        = FileList['[A-Z]*', 'lib/**/*.rb', 'test/**/*.rb']
  s.require_path = 'lib'
  s.test_files   = Dir[*['test/**/*_test.rb']]
  s.homepage = "http://github.com/cwninja/active_record_lint"

  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.markdown"]
  s.rdoc_options = ['--line-numbers', '--inline-source', "--main", "README.markdown"]

  s.authors = ["Tom Lea"]
  s.email   = %q{commits@tomlea.co.uk}

  s.platform = Gem::Platform::RUBY
end

Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = true
  pkg.need_zip = true
end

desc "Clean files generated by rake tasks"
task :clobber => [:clobber_rdoc, :clobber_package]

desc "Generate a gemspec file"
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end

