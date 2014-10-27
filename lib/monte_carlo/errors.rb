module MonteCarlo
  module Errors

    class NoSampleMethodError < StandardError
      @message = 'A sample method for this experiment is not defined'
    end

  end
end
