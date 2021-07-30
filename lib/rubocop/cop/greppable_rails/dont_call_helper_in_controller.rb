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

        def find_parent(node)
          parent_node = node.parent
          if parent_node.type == :begin
            parent_node.parent
          else
            parent_node
          end
        end

        def on_send(node)
          parent_node = find_parent(node)
          return unless parent_node.type == :class

          class_name = parent_node.children.first.children.last.to_s
          return unless class_name.end_with?("Controller")

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
