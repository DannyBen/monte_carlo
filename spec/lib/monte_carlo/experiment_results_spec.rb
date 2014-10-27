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

end
