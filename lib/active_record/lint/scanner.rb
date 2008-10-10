class ActiveRecord::Lint::Scanner
  include ActiveRecord::Lint
  
  def initialize(connection = nil)
    @connection = connection || ActiveRecord::Base.connection
  end
  
  def missing_indexes
    return @missing_indexes if @missing_indexes
    @missing_indexes = (foreign_keys - indexes).inject({}){|acc, (table, key)|
      keys = acc[table] || []
      acc.merge(table => (keys | [key]))
    }
  end
  
  def missing_tables
    classes.map{|klass| klass.table_name } - @connection.tables
  end
  
  def missing_foreign_keys
    foreign_keys - columns
  end
  
  def foreign_keys
    return @foreign_keys if @foreign_keys
    
    @foreign_keys = []
    classes.each do |klass|
      table_name = klass.table_name
      klass.reflect_on_all_associations(:belongs_to).map(&:primary_key_name).each do |foreign_key|
        @foreign_keys << TableColumnPair.new(table_name, foreign_key)
      end
    end
    
    @foreign_keys
  end
  
  def columns
    return @columns if @columns
    
    @columns = []
    @connection.tables.each do |table|
      @connection.columns(table).each do |column|
        @columns << TableColumnPair.new(table, column.name)
      end
    end
    
    columns
  end
  
  def indexes
    return @indexes if @indexes
    
    @indexes = []
    @connection.tables.each do |table|
      column_sets = @connection.indexes(table).map(&:columns)
      column_sets.select{|col| col.size == 1}.flatten.each do |index|
        @indexes << TableIndexPair.new(table, index)
      end
    end
    
    @indexes
  end
  
  def classes
    ActiveRecord::Base.send(:subclasses)
  end
  
end