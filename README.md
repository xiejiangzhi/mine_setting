# MineSetting

Simple load setting files

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mine_setting'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mine_setting

## Usage

config/settings/base.yml
```
development:
  name: base
  env: dev
```

```
class MySetting
  extend MineSetting

  load_dir File.expand_path('../config/settings'), :development
end

MySetting.base # => {'name' => 'base', 'env' => 'dev'}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mine_setting/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
