# Jungle

A mini e-commerce application built with Rails 4.2. Designed to show capabilities with Ruby on Rails even with an older version. If I were to inherit an older code base, I know the basics of how to prepare my computer for it and have the ability to work with the older syntax.

## Final Product

!["Home Page"](https://github.com/GleefullyChill/Jungle_On_Rails/blob/master/public/docs/screenshots/Home%20Page.png)

!["Admin Dashboard and Dropdown Actions"](https://github.com/GleefullyChill/Jungle_On_Rails/blob/master/public/docs/screenshots/Admin%20Actions.png)

!["Full Cart, Ready to Pay"](https://github.com/GleefullyChill/Jungle_On_Rails/blob/master/public/docs/screenshots/Card%20Input%20and%20Cart.png)

!["Successful Order Details"](https://github.com/GleefullyChill/Jungle_On_Rails/blob/master/public/docs/screenshots/Order%20Details.png)

## Additional Steps for Apple M1 Machines

1. Make sure that you are runnning Ruby 2.6.6 (`ruby -v`)
1. Install ImageMagick `brew install imagemagick imagemagick@6 --build-from-source`
2. Remove Gemfile.lock
3. Replace Gemfile with version provided [here](https://gist.githubusercontent.com/FrancisBourgouin/831795ae12c4704687a0c2496d91a727/raw/ce8e2104f725f43e56650d404169c7b11c33a5c5/Gemfile)

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
