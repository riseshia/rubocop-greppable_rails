# frozen_string_literal: true

module RuboCop
  module Cop
    module GreppableRails
      # Prohibits `include` inside helper modules. Including makes it hard
      # to grep where a helper method actually lives, and broadens the
      # constant-dependency surface so that changes to one helper become
      # unpredictably visible from another.
      #
      # @example
      #   # bad
      #   # app/helpers/top_helper.rb
      #   module TopHelper
      #     include PostHelper
      #
      #     def some_link(posts)
      #       some_post_link(posts.first)
      #     end
      #   end
      #
      #   # good
      #   # app/helpers/post_link_tag.rb
      #   module PostLinkTag
      #     module_function
      #
      #     def some_post_link(post)
      #       # ...
      #     end
      #   end
      #
      #   # app/helpers/top_helper.rb
      #   module TopHelper
      #     def some_link(posts)
      #       PostLinkTag.some_post_link(posts.first)
      #     end
      #   end
      class NoIncludeInHelper < Base
        MSG = "Do not include in Helper."
        RESTRICT_ON_SEND = %i[include].freeze

        def_node_matcher :render_with_inline_option?, <<~PATTERN
          (send _ :include (const _ _))
        PATTERN

        def on_send(node)
          parent = node.parent
          parent = parent.parent if parent&.begin_type?
          return unless parent&.module_type?
          return unless parent.identifier.const_name.end_with?("Helper")

          add_offense(node) if render_with_inline_option?(node)
        end
      end
    end
  end
end
