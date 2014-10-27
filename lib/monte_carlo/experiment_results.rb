require 'forwardable'

module MonteCarlo
  class ExperimentResults
    include Enumerable
    extend Forwardable

    attr_reader :results
    def_delegators :@results, :size, :[], :<<, :count, :each, :uniq

    def initialize
      @results = []
    end

    def each(&block)
      @results.each do |result|
        block_given? ? block.call(result) : yield(result)
      end
    end

    def probability_distribution
      @results.group_by(&:value).inject({}) { |percentages, (value, results)| percentages[value] = results.size.to_f / self.size; percentages }
    end

    def frequency_distribution
      @results.group_by(&:value).inject({}) { |counts, (value, results)| counts[value] = results.size; counts }
    end

  end
end
