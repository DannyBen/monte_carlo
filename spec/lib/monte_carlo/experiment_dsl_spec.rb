require 'spec_helper'

describe MonteCarlo::ExperimentDSL do
  let(:experiment) { MonteCarlo::Experiment.new }

  def eval_in_dsl(&block)
    MonteCarlo::ExperimentDSL.new(experiment).instance_eval(&block)
  end

  describe :times do
    it 'should set the amount of times' do
      expect(experiment).to receive(:times=)

      eval_in_dsl do
        times 1
      end
    end
  end

  describe :sample_method do
    it 'should set the sample method' do
      expect(experiment).to receive(:sample_method=)

      eval_in_dsl do
        sample_method { }
      end
    end
  end

  describe :computation do
    let(:test_computation) { -> { } }
    
    it 'should set the computation method' do
      expect(experiment).to receive(:computation=)

      eval_in_dsl do
        computation { }
      end
    end
  end

  describe :setup do
    let(:test_setup) { -> { } }
    
    it 'should set the setup method' do
      expect(experiment).to receive(:setup=)

      eval_in_dsl do
        setup { }
      end
    end
  end

  describe :reset do
    let(:test_reset) { -> { } }
    
    it 'should set the reset method' do
      expect(experiment).to receive(:reset=)

      eval_in_dsl do
        reset { }
      end
    end
  end

end
