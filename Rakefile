require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

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