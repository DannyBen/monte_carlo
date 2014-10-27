module MonteCarlo
  class Result
    include Comparable

    attr_accessor :value, :sample_value, :index

    def initialize(index = nil, value = nil, sample_value = nil)
      @value = value
      @sample_value = sample_value
      @index = index
    end

    def <=> other
      self.to_i <=> other.to_i
    end

    def to_i
      @value
    end

  end
end
