# frozen_string_literal: true

require "lint_roller"

module RuboCop
  module GreppableRails
    # LintRoller plugin entry point. Registers config/default.yml with RuboCop.
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: "rubocop-greppable_rails",
          version: VERSION,
          homepage: "https://github.com/riseshia/rubocop-greppable_rails",
          description: "RuboCop cops for keeping Rails code greppable."
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        project_root = Pathname.new(__dir__).join("../../..")
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: project_root.join("config/default.yml")
        )
      end
    end
  end
end
