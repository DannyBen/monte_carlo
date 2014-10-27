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

  end
end
