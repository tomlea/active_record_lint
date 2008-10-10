unless defined? Memoize
  module Memoize
    def self.included(other)
      other.extend(ClassMethods)
    end
    
    module ClassMethods
      def memoize(*methods)
        methods.each do |method|
          define_method "#{method}_with_memoize" do |*args|
            unless store = instance_variable_get("@_#{method}_memoized")
              instance_variable_set("@_#{method}_memoized", store = {})
            end
            
            store[args] ||= send("#{method}_without_memoize", *args)
          end

          alias_method_chain method, :memoize          
        end
      end
    end
  end
end