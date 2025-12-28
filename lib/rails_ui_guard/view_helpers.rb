# frozen_string_literal: true

module RailsUiGuard
  # View helpers for the blur + overlay UX.
  #
  # This is intentionally **no-JS**. The UI lock is UX only; backend enforcement
  # must still be done with `rails_ui_guard_enforce_active!` for write actions.
  module ViewHelpers
    # Wrap arbitrary content with a blur/freeze overlay when status != :active.
    #
    # Usage (recommended in layout):
    #
    #   <%= rails_ui_guard_wrap(status: @module_status, feature_key: @feature_key, feature_status: @feature_status_record) do %>
    #     <%= yield %>
    #   <% end %>
    #
    def rails_ui_guard_wrap(status:, feature_key: nil, feature_status: nil, &block)
      status = status&.to_sym
      content = capture(&block)

      return content if status.nil? || status == :active

      blurred_classes = "rails-ui-guard-blur rails-ui-guard-opacity rails-ui-guard-block-pointer"
      # `inert` prevents focus/keyboard interaction in modern browsers (no JS needed).
      inert_attr = "inert"

      safe_join(
        [
          content_tag(:div, class: "relative") do
            safe_join(
              [
                content_tag(:div, content, class: blurred_classes, **{ inert: inert_attr }),
                render(
                  "rails_ui_guard/shared/module_overlay",
                  module_status: status,
                  feature_key: feature_key,
                  feature_status: feature_status
                )
              ]
            )
          end
        ]
      )
    end

    # Optional: show lock/maintenance badge for menu items.
    def rails_ui_guard_status_badge(status)
      status = status&.to_sym
      return "" if status.nil? || status == :active

      label, classes, icon =
        case status
        when :locked
          ["Locked", "bg-gray-700 text-gray-200", "🔒"]
        when :under_work
          ["Under Work", "bg-yellow-700 text-yellow-100", "🚧"]
        else
          ["Unavailable", "bg-red-700 text-red-100", "⚠️"]
        end

      content_tag(:span, class: "ml-auto flex items-center gap-1 text-[10px] px-2 py-0.5 rounded #{classes}") do
        safe_join([
          content_tag(:span, icon, class: "text-xs"),
          content_tag(:span, label)
        ])
      end
    end
  end
end


