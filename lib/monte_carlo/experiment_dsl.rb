module MonteCarlo
  class ExperimentDSL

    def initialize(experiment)
      @experiment = experiment
    end

    def times(times)
      @experiment.times = times
    end

    def sample_method(&block)
      @experiment.sample_method = block
    end

    def computation(&block)
      @experiment.computation = block
    end

    def setup(&block)
      @experiment.setup = block
    end

    def reset(&block)
      @experiment.reset = block
    end

  end
end
