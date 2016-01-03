require 'spec_helper'

describe MonteCarlo::Experiment do

  let(:times) { 10 }
  let(:sample_value) { 1 }
  let(:sample_method) { -> { sample_value } }
  let(:computation) { ->(sample) {sample * 2} }
  let(:experiment) do
    experiment = MonteCarlo::Experiment.new
    experiment.times = times
    experiment.sample_method = sample_method
    experiment.computation = computation
    experiment
  end

  describe :initialize do
    shared_examples_for :raises_argument_error do
      it 'should raise an ArgumentError' do
        expect {
          MonteCarlo::Experiment.new(times)
        }.to raise_error ArgumentError
      end
    end

    context 'when `times` is not a number' do
      let(:times) { 'no good' }
      it_behaves_like :raises_argument_error
    end

    context 'when `times` is negative' do
      let(:times) { -1 }
      it_behaves_like :raises_argument_error
    end
  end

  describe :times= do
    shared_examples_for :raises_argument_error do |times|
      it 'should raise an ArgumentError' do
        expect {
          experiment.times = times
        }.to raise_error ArgumentError
      end
    end

    context 'when `times` is not a number' do
      it_behaves_like :raises_argument_error, 'no good'
    end

    context 'when `times` is negative' do
      it_behaves_like :raises_argument_error, -1
    end
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
      expect(results.map(&:sample_value)).to all( eq sample_value )
    end

    it 'should return results with correct values' do
      results = experiment.run
      expect(results.map(&:value)).to all( eq computation.call(sample_value) )
    end
  end

  describe :setup do
    let(:setup) { double(call: nil) }

    before { experiment.setup = setup }

    it 'should run the setup method before each run' do
      expect(setup).to receive(:call).exactly(times).times
      experiment.run
    end
  end

  describe :reset do
    let(:reset) { double(call: nil) }

    before { experiment.reset = reset }

    it 'should run the reset method after each run' do
      expect(reset).to receive(:call).exactly(times).times
      experiment.run
    end

    it 'should run reset method even when sample method raises exception' do
      experiment.sample_method = -> { raise }
      expect(reset).to receive(:call).exactly(:once)
      experiment.run rescue nil
    end
  end

end
