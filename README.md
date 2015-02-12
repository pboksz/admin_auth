# AdminAuth

This a small gem that extracts simple admin database authentication functionality.

It is written in a way that will work with both `ActiveRecord` and `Mongoid` and any other ORM that has the methods `all`, `new`, `create`, `where`, `update_attributes`, `destroy` (And they work in the same fashion).

It requires adding a few things to your code, but handles all the things related to authentication on this basic level, including controllers, views, routing, password encryption (with BCrypt).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'admin_auth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install admin_auth

## Usage

To use this gem you need to do few things:

1. Create an `Admin` model that has two fields:
    - email (string)
    - encrypted_password (string)
2. Add the line `admin_auth_routes` to your `routes.rb` file.
3. Now if you add `before_action authenticate_admin!` to any controller it will send the user to the admin login page.
4. To create an admin you will need to do it in the rails console: `Admin.create(email: 'email@email.com', password: 'password', password_confirmation: 'password')`
5. Optionally, add an `after_login_path` method to your `ApplicationController` that returns the path you want to redirect to when logged in.
6. Optionally, add an `after_logout_path` method to your `ApplicationController` that returns the path you want to redirect to after logout.
7. Optionally, you can copy the views in the gem to `app/views/admin` and modify then how you see fit.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/admin_auth/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
