# Komondor

A helper gem to add single sign on to apps.

## Installation

Add this line to your application's Gemfile:

    gem 'komondor'

And then execute:

    $ bundle

Then run the installer

    $ rails g komondor:install


## Usage

We use 3 environment variables in each connected app

    SSO_SECRET_KEY=the secret key of the app
    SSO_URL=the domain of the auth provider
    SSO_NAME=the name of the auth provider

For any controllers you wish to protect, you need to add a before filter

```ruby
# For Rails 3
before_filter :guard_dog

# For Rails 4
before_action :guard_dog
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
