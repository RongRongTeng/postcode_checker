# Postcode Checker

Postcode Checker is a web-based tool in Ruby on Rails for checking whether your UK postcode is in the service area.

- Use the Postcodes.io API as source for data
- Support whitelist management

## Requirement

- ruby 2.6.3
- mysql
- redis


### Update configuration files

```
setup .env file (or .env.development), refer to the example file at .env.example
```

### Install Gem and Setup Database

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

### Run the server

Just run the rails command to start the server

```
bundle exec rails s
```

Then visit http://localhost:3000


### Testing

```
bundle exec rspec
```

## Better in Next
- Add a web-based management tool for admin users to manage whilelists.
