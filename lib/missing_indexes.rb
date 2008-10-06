module MissingIndexes
  def load_models(rails_root)
    pattern = File.join(rails_root, "app", "models", "*.rb")
    Dir.glob(pattern).each{|p| require p }
  end
  
  def missing_indexes
    load_models(RAILS_ROOT)
    References.new(ActiveRecord::Base.connection).check
  end
  
  extend self
end


Dir.glob(File.join(File.dirname(__FILE__), "missing_indexes", "*.rb")) do |file|
  require file
end