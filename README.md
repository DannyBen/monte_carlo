# MonteCarlo

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

Each experiment conatins:
- `times`: the number of sample to create (defaults to 10,000)
- `sample_method`: the method with which to generate a sample each iteration
- `sample_transformation`: an optional transformation method to run on each sample

For example;

```ruby
# Create an experiment with an optional number of times
experiment = MonteCarlo::Experiment.new(100000)

# Set your smaple method
experiment.sample_method = -> { rand }

# Set your optional transformation method
experiment.sample_transformation = -> (sample) { sample > 0.5 }

# Run your experiment and get your results
results = experiment.run
```

Alternatively, if you don't need a transformation method, use the shorthand block syntax:

```ruby
results = MonteCarlo::Experiment.run(100000) { rand > 0.5 }
```

The experiment returns a `MonteCarlo::ExperimentResults` object which contains an array of `MonteCarlo::Results` as well as some other handy methods.

Each `MonteCarlo::Result` contains:
- `index`: the index of the sample
- `value`: the final value returned from sampling, after transformation
- `sample_value`: the value returned from the sample method, before transformation

If no transformation method was given, `value` and `sample_value` will be the same.

## Contributing

1. Fork it ( https://github.com/[agelber]/monte_carlo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
