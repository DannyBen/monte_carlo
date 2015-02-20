module MonteCarlo
  # Class to run your Monte Carlo experiments
  #
  # @example
  #   experiment = MonteCarlo::Experiment.new
  #   experiment.sample_method = -> { rand(10) }
  #   results = experiment.run
  class Experiment

    # The default number of sample methods to generate
    DEFAULT_TIMES = 10000

    # @!attribute times 
    #   @return [#times] the number of samples to generate
    # @!attribute sample_method
    #   @return [#call] a method to generate a sample each time
    # @!attribute computation
    #   @return [#call] a method to turn a random sample to a meaningful result
    # @!attribute setup
    #   @return [#call] a method to run before each iteration
    # @!attribute reset
    #   @return [#call] a method to run after each iteration
    attr_accessor :times, :sample_method, :computation, :setup, :reset

    # Shorthand syntax to run a simple experiment
    #
    # @example
    #   results = MonteCarlo::Experiment.run(100000) { rand(10) }
    #
    # @param times [optional, #times] the number of samples to generate
    # @param block [Block] the method to generate one sample each iteration
    # @raise [MonteCarlo::Errors::NoSampleMethodError] if no block is given
    # @return [MonteCarlo::ExperimentResults]
    def self.run(times = DEFAULT_TIMES, &block)
      experiment = MonteCarlo::Experiment.new(times)
      experiment.sample_method = block
      experiment.run
    end

    # Initialize a new experiment
    #
    # @example
    #   experiment = MonteCarlo::Experiment.new do
    #     times 100000
    #     sample_method { rand(10) }
    #     computation { |sample| sample >= 5  }
    #   end
    #   
    #   results = experiment.run
    #
    # @param times [optional, #times] the number of samples to generate
    # @param block [optional, Block] a block to configure the experiment using the {MonteCarlo::ExperimentDSL}
    # @return [MonteCarlo::Experiment]
    def initialize(times = DEFAULT_TIMES, &block)
      @times = times
      raise ArgumentError, "`times` must be a positive integer" unless valid_times?
      MonteCarlo::ExperimentDSL.new(self).instance_eval(&block) if block_given?
    end

    def times=(times)
      @times = times
      raise ArgumentError, "`times` must be a positive integer" unless valid_times?
    end

    # Run the experiment
    #
    # @raise [MonteCarlo::Errors::NoSampleMethodError] if the experiment has no sample method set
    # @return [MonteCarlo::ExperimentResults]
    def run
      if @sample_method.nil?
        raise MonteCarlo::Errors::NoSampleMethodError, 'A sample method for this experiment is not defined'
      end

      results = MonteCarlo::ExperimentResults.new

      @times.times do |index|
        begin
          @setup.call() unless @setup.nil?
          results << run_sample(index)
        ensure
          @reset.call() unless @reset.nil?
        end
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

    def valid_times?
      @times.is_a?(Fixnum) && @times > 0
    end

  end
end
