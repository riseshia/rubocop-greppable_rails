# frozen_string_literal: true

module RuboCop
  module Cop
    module GreppableRails
      # This cop looks for include Helper execution.
      # Including Helper, in most cases, makes:
      # - hard to find out some helper method is used or not.
      # - constant dependency more complex, which causes changing code how impact to be unpredictable.
      #
      # @example
      #   # bad
      #   # app/helpers/post_helper.rb
      #   module PostHelper
      #     def some_post_link(post)
      #       # make some awesome link...
      #     end
      #   end
      #
      #   # app/helpers/top_helper.rb
      #   module TopHelper
      #     include PostHelper
      #
      #     def some_link(posts)
      #       some_post_link(post)
      #     end
      #   end
      #
      #   # good
      #   # app/helpers/post_link_tag.rb
      #   module PostLinkTag
      #     module_function
      #
      #     def some_post_link(post)
      #       # make some awesome link...
      #     end
      #   end
      #
      #   # app/helpers/top_helper.rb
      #   module TopHelper
      #     def some_link(posts)
      #       PostLinkTag.some_post_link(post)
      #     end
      #   end
      #
      class DontIncludeInHelper < Base
        MSG = "Do not include in Helper."
        RESTRICT_ON_SEND = %i[include].freeze

        def_node_matcher :render_with_inline_option?, <<~PATTERN
          (send _ :include (const _ _))
        PATTERN

        def on_send(node)
          parent_node = node.parent
          return unless parent_node.type == :module

          module_name = parent_node.children.first.children.last.to_s
          return unless module_name.end_with?("Helper")

          add_offense(node) if render_with_inline_option?(node)
        end
      end
    end
  end
end
