# frozen_string_literal: true

RSpec.describe RuboCop::Cop::GreppableRails::DontCallHelperInController, :config do
  it "registers an offense when call helper in Controller" do
    expect_offense(<<~RUBY)
      class FooController
        helper :bar
        ^^^^^^^^^^^ Don't include helper via call helper in Controller.
      end
    RUBY
  end

  it "does not register an offense when call helper in method scope" do
    expect_no_offenses(<<~RUBY)
      class FooController
        def index
          helper :bar
        end
      end
    RUBY
  end

  it "does not register an offense when call helper not in Controller" do
    expect_no_offenses(<<~RUBY)
      class Foo
        helper :bar
      end
    RUBY
  end
end
