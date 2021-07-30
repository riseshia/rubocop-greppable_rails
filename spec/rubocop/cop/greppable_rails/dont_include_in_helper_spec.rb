# frozen_string_literal: true

RSpec.describe RuboCop::Cop::GreppableRails::DontIncludeInHelper, :config do
  it "registers an offense when module including some constant" do
    expect_offense(<<~RUBY)
      module UserHelper
        include Post
        ^^^^^^^^^^^^ Do not include in Helper.
      end
    RUBY
  end

  it "does not register an offense when include not in Helper" do
    expect_no_offenses(<<~RUBY)
      module User
        include Post
      end
    RUBY
  end

  it "does not register an offense with class" do
    expect_no_offenses(<<~RUBY)
      class User
        include Post
      end
    RUBY
  end
end
