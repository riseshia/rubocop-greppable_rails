# rubocop-greppable_rails

A collection of RuboCop cops that discourage Rails patterns which obscure where code comes from (helper inclusion, non-inline access modifiers, etc.) — so plain `grep` stays a useful tool when navigating your codebase.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "rubocop-greppable_rails", require: false
```

And then execute:

```sh
bundle install
```

## Usage

Register the plugin in your `.rubocop.yml`:

```yaml
plugins:
  - rubocop-greppable_rails
```

## Cops

### `GreppableRails/NoIncludeInHelper`

Prohibits `include` inside helper modules. Including makes it hard to grep where a helper method actually lives, and broadens the constant-dependency surface.

Applies to: `app/helpers/**/*.rb`.

```ruby
# bad
module TopHelper
  include PostHelper

  def some_link(posts)
    some_post_link(posts.first)
  end
end

# good
module PostLinkTag
  module_function

  def some_post_link(post)
    # ...
  end
end

module TopHelper
  def some_link(posts)
    PostLinkTag.some_post_link(posts.first)
  end
end
```

### `GreppableRails/NoHelperInController`

Prohibits `helper :name` calls at class scope in controllers. Implicit helper inclusion makes the helper method's call site impossible to grep from the controller.

Applies to: `app/controllers/**/*.rb`.

```ruby
# bad
class FoosController < ApplicationController
  helper :bar
end

# good — call the helper module explicitly where you need it
class FoosController < ApplicationController
  def show
    @label = BarHelper.label_for(@foo)
  end
end
```

### `GreppableRails/UseInlineAccessModifier`

Enforces inline-style access modifiers (`private def foo`) over group style (`private` then `def foo`) and symbol-arg style (`private :foo`). Inline form makes a method's visibility greppable on the same line as the definition.

```ruby
# bad
class Foo
  private

  def bar; end
end

class Foo
  def bar; end
  private :bar
end

# good
class Foo
  private def bar; end
end
```

## Configuration

Each cop accepts the standard RuboCop options (`Enabled`, `Exclude`, `Include`, …). Default `Include` paths are set in [`config/default.yml`](config/default.yml) and can be overridden in your project's `.rubocop.yml`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt.

```sh
bundle exec rspec     # tests
bundle exec rake      # rubocop
```

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/riseshia/rubocop-greppable_rails>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
