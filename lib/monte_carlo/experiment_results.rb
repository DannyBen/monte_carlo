module MonteCarlo
  class ExperimentResults
    include Enumerable

    def initialize
      @results = []
    end

    def each(&block)
      @results.each do |result|
        block_given? ? block.call(result) : yield(result)
      end
    end

    def << result
      @results << result
      reset_memoizers
    end

    def size
      @results.size
    end

    def probability_distribution
      @probability_distribution ||= @results.group_by(&:value).inject({}) do |probabilites, (value, results)|
        probabilites[value] = results.size.to_f / self.size
        probabilites
      end
    end

    def frequency_distribution
      @frequency_distribution ||= @results.group_by(&:value).inject({}) do |frequencies, (value, results)|
        frequencies[value] = results.size
        frequencies
      end
    end

    def probability_of(value)
      probability_distribution.fetch(value, 0)
    end

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
