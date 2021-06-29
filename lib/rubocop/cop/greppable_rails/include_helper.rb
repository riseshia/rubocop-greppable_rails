# frozen_string_literal: true

module RuboCop
  module Cop
    module ReadableRails
      # This cop looks for inline rendering within controller actions.
      #
      # @example
      #   # bad
      #   class ProductsController < ApplicationController
      #     def index
      #       render inline: "<% products.each do |p| %><p><%= p.name %></p><% end %>", type: :erb
      #     end
      #   end
      #
      #   # good
      #   # app/views/products/index.html.erb
      #   # <% products.each do |p| %>
      #   #   <p><%= p.name %></p>
      #   # <% end %>
      #
      #   class ProductsController < ApplicationController
      #     def index
      #     end
      #   end
      #
      class IncludeHelper < Base
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
