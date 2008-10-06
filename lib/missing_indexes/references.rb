class MissingIndexes::References
  
  def initialize(connection = nil)
    @connection = connection || ActiveRecord::Base.connection
  end
  
  def check
    all_foreign_keys.inject({}) do |acc, (table_name, keys)|
      none_indexed_keys = (keys || []) - (indexes_by_table[table_name] || [])
      if none_indexed_keys.any?
        acc.merge(table_name => none_indexed_keys)
      else
        acc
      end
    end
  end

  def all_foreign_keys
    table_fk_map = table_names.inject({}){|acc, table_name| acc.merge(table_name.to_sym => [])}

    classes.each do |klass|
      table_name = klass.table_name.to_sym
      table_fk_map[table_name] += klass.reflect_on_all_associations(:belongs_to).map(&:primary_key_name).map(&:to_sym)
    end
    
    table_fk_map
  end
  
  def indexes_by_table
    @indexes_by_table ||= @connection.tables.inject({}) do |acc, table|
      column_sets = @connection.indexes(table).map(&:columns)
      single_column_indexes = column_sets.select{|col| col.size == 1}.flatten
      acc.merge(table.to_sym => single_column_indexes.map(&:to_sym))
    end
  end
    
  def table_names
    classes.map(&:table_name)
  end
  
  def classes
    ActiveRecord::Base.send(:subclasses)
  end
  
end