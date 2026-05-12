# frozen_string_literal: true

module RuboCop
  module Cop
    module GreppableRails
      # @example
      #   # bad
      #   class FooController
      #     helper :bar
      #   end
      class DontCallHelperInController < Base
        MSG = "Don't include helper via call helper in Controller."

        RESTRICT_ON_SEND = %i[helper].freeze

        def_node_matcher :helper_call?, <<~PATTERN
          (send nil? {:helper} (sym _))
        PATTERN

        def on_send(node)
          parent = node.parent
          parent = parent.parent if parent&.begin_type?
          return unless parent&.class_type?
          return unless parent.identifier.const_name.end_with?("Controller")

          add_offense(node) if offense?(node)
        end

        private

        def offense?(node)
          return true if node.arguments.empty?

          node.arguments.first.type == :sym
        end
      end
    end
  end
end
