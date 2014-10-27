require 'spec_helper'

describe MonteCarlo::Experiment do

  let(:times) { 1000 }
  let(:sample_value) { 1 }
  let(:sample_transformation) { -> (sample) {sample * 2} }
  let(:experiment) do
    experiment = MonteCarlo::Experiment.new
    experiment.times = 1000
    experiment.sample_method = -> { sample_value }
    experiment.sample_transformation = sample_transformation
    experiment
  end

  describe :run do
    it 'should call the sample_method the correct number of times' do
      sample_double = double(call: sample_value)
      experiment.sample_method = sample_double
      expect(sample_double).to receive(:call).exactly(times).times
      experiment.run
    end

    it 'should return an array of result objects' do
      results = experiment.run
      expect(results).to all( be_a MonteCarlo::Result )
    end

    it 'should return results with correct sample values' do
      results = experiment.run
      expect(results.map(&:sample_value)).to all( eq sample_value)
    end

    it 'should return results with correct values' do
      results = experiment.run
      expect(results.map(&:value)).to all( eq sample_transformation.call(sample_value))
    end
  end

end
