# MonteCarlo [![Build Status](https://travis-ci.org/agelber/monte_carlo.svg)](https://travis-ci.org/agelber/monte_carlo)

A utility to write quick [Monte Carlo Method](http://en.wikipedia.org/wiki/Monte_Carlo_method) experiments.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monte_carlo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monte_carlo

## Usage

Every `MonteCarlo::Experiment` must have a sample method to generate random samples. The samples generated when the experiment is run will be collected into a `MonteCarlo::ExperimentResults` object after an optional computation method to turn the random sample into a meaningful value.
For example, the sample method may draw a random number between 1 and 10 and the computation method will test whether the number is greater than 5, returning `true` or `false` results.

```ruby
# Create an instance and configure it with the DSL
experiment = MonteCarlo::Experiment.new do
  times 1000000
  sample_method { rand(10) }
  computation { |sample| sample >= 5 }
end

results = experiment.run

results.probability_distribution
# => {true=>0.499443, false=>0.500557}
```

Or run it with the shorthand class method syntax:

## Docs

[Can be found here](http://www.rubydoc.info/gems/monte_carlo)

## Contributing

1. Fork it ( https://github.com/agelber/monte_carlo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
