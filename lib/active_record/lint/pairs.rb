module ActiveRecord::Lint
  class Pair
    include Comparable
    attr_accessor :a, :b
    
    def initialize(a, b)
      @a,@b=a,b
    end
    
    def <=>(other)
      (a <=> other.a).zero? ? (b <=> other.b) : (a <=> other.a)
    end
    
    def eql?(other)
      (self <=> other) == 0
    end
    
    def pair_name
      @pair_name ||= self.class.name.split("::").last
    end
    
    def inspect
      "#{pair_name}[#{a.inspect}, #{b.inspect}]"
    end

    def hash
      a.hash ^ b.hash
    end
    
    def to_ary
      [a,b]
    end
    
    alias to_a to_ary

    class << self
      alias [] new
    end    
  end

  class TableColumnPair < Pair
    alias table  a
    alias column b
  end

  class TableKeyPair < TableColumnPair
    alias key   b
  end

  class TableIndexPair < TableColumnPair
    alias index b
  end
end