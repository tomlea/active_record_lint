namespace :db do
  namespace :missing_indexes do
    
    desc 'Shows missing indexes on foreign keys'
    task :show => :environment do
      require File.join(File.dirname(__FILE__), "..", "lib", "missing_indexes")

      MissingIndexes.missing_indexes.each do |(table, fields)|
        puts "#{table}:"
        puts " " + fields.join(", ")
      end
    end
  
    desc 'Writes create index commands needed to add missing foreign key indexes to stdout '
    task :show_fix => :environment do
      require File.join(File.dirname(__FILE__), "..", "lib", "missing_indexes")

      MissingIndexes.missing_indexes.each do |(table, fields)|
        fields.each do |field|
          puts "add_index #{table.inspect}, #{field.inspect}"
        end
      end
    end
    
  end
end