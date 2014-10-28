require 'spec_helper'

describe MonteCarlo::ExperimentResults do

  let(:times) { 99 }
  let(:results) do
    results = MonteCarlo::ExperimentResults.new
    times.times do |index|
      results << MonteCarlo::Result.new(index, index % 3 == 0)
    end
    results
  end

  shared_examples_for :of_methdds do |method|
    it 'returns 0 when the value does not exist' do
      expect(results.send(method, 'does not exist')).to eq 0
    end
  end

  describe :probability_distribution do
    it 'should return the correct probability distribution for the results' do
      expect(results.probability_distribution.keys).to contain_exactly(true, false)
      expect(results.probability_distribution[true]).to eq 1 / 3.0
      expect(results.probability_distribution[false]).to eq 2 / 3.0
    end
  end

  describe :frequency_distribution do
    it 'should return the correct frequency distribution for the results' do
      expect(results.frequency_distribution.keys).to contain_exactly(true, false)
      expect(results.frequency_distribution[true]).to eq 33
      expect(results.frequency_distribution[false]).to eq 66
    end
  end

  describe :probability_of do
    it_behaves_like :of_methdds, :probability_of

    it 'should return the correct probability of a value' do
      expect(results.probability_of(true)).to eq 1 / 3.0
    end
  end

  describe :frequency_of do
    it_behaves_like :of_methdds, :frequency_of

    it 'should return the correct frequency of a value' do
      expect(results.frequency_of(true)).to eq 33
    end
  end

end
