# ToSentenceExclusive

Converts the array to a comma-separated sentence where the last element is joined by the connector word, defaulting to an exclusive sentence structure ("one, two, or three" as opposed to "one, two, and three").

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'to_sentence_exclusive'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install to_sentence_exclusive

## Usage

You can pass the following options to change the default behavior. If you pass an option key that doesn't exist in the list below, it will raise an ArgumentError.

### Options

- :words_connector - The sign or word used to join the elements in arrays with two or more elements (default: ", ").
- :two_words_connector - The sign or word used to join the elements in arrays with two elements (default: " and ").
- :last_word_connector - The sign or word used to join the last element in arrays with three or more elements (default: ", and ").
- :locale - If i18n is available, you can set a locale and use the connector options defined on the 'support.array' namespace in the corresponding dictionary file.

### Examples

```ruby
[].to_sentence                      # => ""
['one'].to_sentence                 # => "one"
['one', 'two'].to_sentence          # => "one and two"
['one', 'two', 'three'].to_sentence # => "one, two, and three"

['one', 'two'].to_sentence(passing: 'invalid option')
# => ArgumentError: Unknown key: :passing. Valid keys are: :words_connector, :two_words_connector, :last_word_connector, :locale

['one', 'two'].to_sentence(two_words_connector: '-')
# => "one-two"

['one', 'two', 'three'].to_sentence(words_connector: ' and ', last_word_connector: ' and lastly ')
# => "one or two or at least three"
```

**Using `:locale` option:**

```ruby
# Given this locale dictionary:
#
#   es:
#     support:
#       array:
#         words_connector: " y "
#         two_words_connector: " y "
#         last_word_connector: " y por ultimo "

['uno', 'dos'].to_sentence(locale: :es)
# => "uno y dos"

['uno', 'dos', 'tres'].to_sentence(locale: :es)
# => "uno y dos y por ultimo tres"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MartinHarding/to_sentence_exclusive.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
