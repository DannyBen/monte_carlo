module MonteCarlo
  # Class to setup an experiment using a DSL syntax
  class ExperimentDSL

    # Initializes a DSL instance for the given experiment
    #
    # @example
    #   experiment = MonteCarlo::Experiment.new do
    #     times 100000
    #     sample_method { rand(10) }
    #     computation { |sample| sample >= 5  }
    #   end
    #
    # @param experiment [MonteCarlo::Experiment] the experiment to configure
    # @return [MonteCarlo::ExperimentDSL]
    def initialize(experiment)
      @experiment = experiment
    end

    # Set the number of samples to generate
    #
    # @param times [#times]
    def times(times)
      @experiment.times = times
    end

    # Set the sample method of the experiment
    #
    # @param block [Block]
    def sample_method(&block)
      @experiment.sample_method = block
    end

    # Set the computation method of the experiment
    #
    # @param block [Block]
    def computation(&block)
      @experiment.computation = block
    end

    # Set the setup method of the experiment
    #
    # @param block [Block]
    def setup(&block)
      @experiment.setup = block
    end

    # Set the reset method of the experiment
    #
    # @param block [Block]
    def reset(&block)
      @experiment.reset = block
    end

  end
end
