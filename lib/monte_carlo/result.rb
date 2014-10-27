module MonteCarlo
  class Result

    attr_accessor :value, :sample_value, :index

    def initialize(index = nil, value = nil, sample_value = nil)
      @value = value
      @sample_value = sample_value
      @index = index
    end

  end
end
