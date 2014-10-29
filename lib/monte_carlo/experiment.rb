module MonteCarlo
  class Experiment

    DEFAULT_TIMES = 10000

    attr_accessor :times, :sample_method, :computation

    def self.run(times = DEFAULT_TIMES, &block)
      MonteCarlo::Experiment.new(times, &block).run
    end

    def initialize(times = DEFAULT_TIMES, &block)
      @times = times
      @sample_method = block
    end

    def run
      if @sample_method.nil?
        raise MonteCarlo::Errors::NoSampleMethodError, 'A sample method for this experiment is not defined'
      end

      results = MonteCarlo::ExperimentResults.new

      @times.times do |index|
        results << run_sample(index)
      end

      results
    end

    private

    def run_sample(index)
      result = MonteCarlo::Result.new(index)
      result.sample_value = @sample_method.call()
      if @computation.nil?
        result.value = result.sample_value
      else
        result.value = @computation.call(result.sample_value)
      end

      result
    end

  end
end
