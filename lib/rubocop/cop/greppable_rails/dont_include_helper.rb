# frozen_string_literal: true

module RuboCop
  module Cop
    module ReadableRails
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
      class DontIncludeHelper < Base
        MSG = "Do not include Helper."
        RESTRICT_ON_SEND = %i[include].freeze

        def_node_matcher :render_with_inline_option?, <<~PATTERN
          (send _ :include (const _ %1))
        PATTERN

        def on_send(node)
          add_offense(node) if render_with_inline_option?(node, /^.+Helper$/)
        end
      end
    end
  end
end
