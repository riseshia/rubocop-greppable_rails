# frozen_string_literal: true

module RuboCop
  module Cop
    module GreppableRails
      # @example
      #   # bad
      #   class Foo
      #     def bar; end
      #     private :bar
      #
      #     private
      #     def baz; end
      #   end
      #
      #   # good
      #   class Foo
      #     private def bar; end
      #     private def baz; end
      #   end
      class UseInlineAccessModifier < Base
        MSG = "Use inline style access modifier."

        RESTRICT_ON_SEND = %i[private protected].freeze

        def_node_matcher :access_modifier_with_symbol?, <<~PATTERN
          (send nil? {:private :protected} (sym _))
        PATTERN

        def on_send(node)
          return unless node.access_modifier?
          return if node.parent&.pair_type?

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
