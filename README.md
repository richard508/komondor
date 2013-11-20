# Komondor

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'single_sign_on'

And then execute:

    $ bundle

## Usage

TODO: Write usage instructions here

For any controllers you wish to protect, you need to add a before filter

```ruby
# For Rails 3
before_filter :signed_in_user

# For Rails 4
before_action :signed_in_user
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
