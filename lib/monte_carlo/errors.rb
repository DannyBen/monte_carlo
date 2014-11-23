module MonteCarlo
  module Errors

    # Raised when trying to run an experiment before setting a sample method
    class NoSampleMethodError < StandardError; end

  end
end
