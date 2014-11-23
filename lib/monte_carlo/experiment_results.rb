module MonteCarlo
  # Class containing the results of a {MonteCarlo::Experiment}
  class ExperimentResults
    include Enumerable

    def initialize
      @results = []
    end

    # Returns an enumerable of the results or runs the given block
    #
    # @param block [optional, Block] the block to run on each of the results
    def each(&block)
      @results.each do |result|
        block_given? ? block.call(result) : yield(result)
      end
    end

    # Add a result to the list
    #
    # @param result [MonteCarlo::Result]
    def << result
      @results << result
      reset_memoizers
    end

    # The number of results
    #
    # @return [Fixnum]
    def size
      @results.size
    end

    # Calculates the probabilty distribution of the results
    #
    # @return [Hash]
    def probability_distribution
      @probability_distribution ||= @results.group_by(&:value).inject({}) do |probabilites, (value, results)|
        probabilites[value] = results.size.to_f / self.size
        probabilites
      end
    end

    # Calculates the frequency distibution of the results
    #
    # @return [Hash]
    def frequency_distribution
      @frequency_distribution ||= @results.group_by(&:value).inject({}) do |frequencies, (value, results)|
        frequencies[value] = results.size
        frequencies
      end
    end

    # Calcuates the probablity of the given value in the results
    #
    # @param value the value for which to get the probability
    # @return [Float]
    def probability_of(value)
      probability_distribution.fetch(value, 0)
    end

    # Calculates the frequency of the given value in the results
    #
    # @param value the value for which to get the frequency
    # @return [Fixnum]
    def frequency_of(value)
      frequency_distribution.fetch(value, 0)
    end

    private

    def reset_memoizers
      @probability_distribution = nil
      @frequency_distribution = nil
    end
  end
end
