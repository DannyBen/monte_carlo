module MonteCarlo
  class Experiment

    DEFAULT_TIMES = 10000

    attr_accessor :times, :sample_method, :sample_transformation

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
        result = MonteCarlo::Result.new(index)
        result.sample_value = @sample_method.call()
        if @sample_transformation.nil?
          result.value = result.sample_value
        else
          result.value = @sample_transformation.call(result.sample_value)
        end

        results << result
      end

      results
    end

  end
end
