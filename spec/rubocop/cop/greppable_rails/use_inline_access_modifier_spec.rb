# frozen_string_literal: true

RSpec.describe RuboCop::Cop::GreppableRails::UseInlineAccessModifier, :config do
  it "registers an offense when group style" do
    expect_offense(<<~RUBY)
      class Foo
        private
        ^^^^^^^ Use inline style access modifier.
        def bar
        end
      end
    RUBY
  end

  it "registers an offense when symbol argument style" do
    expect_offense(<<~RUBY)
      class Foo
        def bar
        end
        private :bar
        ^^^^^^^^^^^^ Use inline style access modifier.
      end
    RUBY
  end

  it "does not register an offense when inline style" do
    expect_no_offenses(<<~RUBY)
      class Foo
        private def bar
        end
      end
    RUBY
  end
end
