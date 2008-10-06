class MissingIndexes::Basic

  def initialize(connection)
    @connection = connection
  end

  def check
    @connection.tables.inject({}) do |acc, table|
      missing_indexes_for_table = check_table(table)
      if missing_indexes_for_table and missing_indexes_for_table.any?
        acc.merge(table.to_sym => missing_indexes_for_table)
      else
        acc
      end
    end
  end

  private
  def check_table(table)
    foreign_keys = @connection.columns(table).map(&:name).select{|column| column =~ /_id$/ }
    none_indexed_foreign_keys = foreign_keys - indexes(table)
    none_indexed_foreign_keys.map(&:to_sym)
  end

  def indexes(table)
    @connection.indexes(table).map(&:columns).flatten
  end

end
