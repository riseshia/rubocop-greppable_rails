# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("lib", __dir__)

require "rubocop/greppable_rails/version"

Gem::Specification.new do |spec|
  spec.name          = "rubocop-greppable_rails"
  spec.version       = RuboCop::GreppableRails::VERSION
  spec.authors       = ["Shia"]
  spec.email         = ["rise.shia@gmail.com"]

  spec.summary       = "RuboCop cops for keeping Rails code greppable."
  spec.description   = "A collection of RuboCop cops that discourage Rails patterns " \
                       "which obscure where code comes from (helper inclusion, " \
                       "non-inline access modifiers, etc.), so grep stays useful."
  spec.homepage      = "https://github.com/riseshia/rubocop-greppable_rails"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/riseshia/rubocop-greppable_rails/blob/main/CHANGELOG.md"
  spec.metadata["default_lint_roller_plugin"] = "RuboCop::GreppableRails::Plugin"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", ">= 1.72.0"
end
