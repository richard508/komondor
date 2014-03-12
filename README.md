# Komondor

A helper gem to add single-sign-on to rails apps.

## Installation

Add this line to your application's Gemfile:

    gem 'komondor'

And then execute:

    $ bundle

Then run the installer

    $ rails g komondor:install

Then run migrations

    $ rake db:migrate


## Basic Usage

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

## Advanced Usage

### Top Bar

By default this gem adds a topbar to your page that will add links to all apps the signed in user has the ability to access. Once installed, you can edit the style of the top bar with the `komondor.css.scss` file added to `app/assets/stylesheets`.

If you don't want to use the top bar, you can remove the folllowing lines from their respective files:

_**app/assets/javascripts/application.js**_

```js
//= require komondor
```

_**app/views/layouts/application.html.erb**_

```html
<script>Komondor = { identity_id: <%= current_user.identity_id %> };</script>
```

And delete the stylesheet: `komondor.css.scss`

Without the topbar you will need to add a signout link:

```erb
<%= link_to "Signout", sessions_path, method: :delete %>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
