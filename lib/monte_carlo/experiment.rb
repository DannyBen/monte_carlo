module MonteCarlo
  class Experiment

    attr_accessor :times, :sample_method, :sample_transformation, :results

    def run
      @results = []

      @times.times do |index|
        result = MonteCarlo::Result.new(index)
        result.sample_value = @sample_method.call()
        if @sample_transformation.nil?
          result.value = result.sample_value
        else
          result.value = @sample_transformation.call(result.sample_value)
        end

        @results << result
      end

      @results
    end

  end
end
