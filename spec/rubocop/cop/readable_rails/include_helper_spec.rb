# frozen_string_literal: true

RSpec.describe RuboCop::Cop::ReadableRails::IncludeHelper, :config do
  it "registers an offense when module including Helper" do
    expect_offense(<<~RUBY)
      include PostHelper
      ^^^^^^^^^^^^^^^^^^ Do not include Helper.
    RUBY
  end

  it "does not register an offense when rendering a template" do
    expect_no_offenses(<<~RUBY)
      module UserHelper
        include Post
      end
    RUBY
  end
end
