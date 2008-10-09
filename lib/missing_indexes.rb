require 'rubygems'
require 'active_record'

module MissingIndexes
  def load_models(rails_root)
    pattern = File.join(rails_root, "app", "models", "*.rb")
    Dir.glob(pattern){|file|
      load( file )
    }
  end
  
  def unload_models
    models = ActiveRecord::Base.send :class_variable_get, :@@subclasses
    models = models.keys - [ActiveRecord::Base]
    models.map(&:name).each do |name|
      Object.send :remove_const, name
    end
    ActiveRecord::Base.send :class_variable_set, :@@subclasses, {}
  end
  
  def missing_indexes(options = {})
    load_models(options[:rails_root] || RAILS_ROOT)
    Scanner.new(options[:connection] || ActiveRecord::Base.connection).missing_indexes
  end
  
  extend self
end


Dir.glob(File.join(File.dirname(__FILE__), "missing_indexes", "*.rb")) do |file|
  require file
end