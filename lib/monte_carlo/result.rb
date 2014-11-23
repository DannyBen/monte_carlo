module MonteCarlo
  # Class that contains the result of a single sample of a {MonteCarlo::Experiment}
  class Result
    include Comparable

    # @!attribute value
    #   @return the value returned after the computation
    # @!attribute sample_value
    #   @return the raw value returned from the sample method
    # @!attribute index
    #   @return [Fixnum] the index of the iteration the result was generated at
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
