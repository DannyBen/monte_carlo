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
      self.value <=> other.value
    end

  end
end
