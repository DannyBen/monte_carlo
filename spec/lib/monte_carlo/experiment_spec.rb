require 'spec_helper'

describe MonteCarlo::Experiment do

  let(:times) { 10 }
  let(:sample_value) { 1 }
  let(:computation) { -> (sample) {sample * 2} }
  let(:experiment) do
    experiment = MonteCarlo::Experiment.new
    experiment.times = times
    experiment.sample_method = -> { sample_value }
    experiment.computation = computation
    experiment
  end

  describe :run do
    it 'should raise a NoSampleMethodError if a sample method is not defined' do
      experiment.sample_method = nil
      expect {
        experiment.run
      }.to raise_error MonteCarlo::Errors::NoSampleMethodError
    end

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
      expect(results.map(&:value)).to all( eq computation.call(sample_value))
    end
  end

  describe :before_each do
    let(:before) { double(call: nil) }

    before { experiment.before_each = before }

    it 'should run the before_each method before each run' do
      expect(before).to receive(:call).exactly(times).times
      experiment.run
    end
  end

  describe :after_each do
    let(:after) { double(call: nil) }

    before { experiment.after_each = after }

    it 'should run the after_each method after each run' do
      expect(after).to receive(:call).exactly(times).times
      experiment.run
    end

    it 'should run even when sample method raises exception' do
      experiment.sample_method = -> { raise }
      expect(after).to receive(:call).exactly(:once)
      experiment.run rescue nil
    end
  end

end
