# frozen_string_literal: true

module RailsUiGuard
  class Engine < ::Rails::Engine
    isolate_namespace RailsUiGuard
    engine_name "rails_ui_guard"

    # Configure paths for views, models, and assets
    config.autoload_paths << root.join("app", "models")
    
    paths["app/views"] = root.join("app", "views")
    paths["app/models"] = root.join("app", "models")
    paths["app/helpers"] = root.join("app", "helpers")
    paths["app/assets"] = root.join("app", "assets")

    # Load the FeatureStatus model after Rails is fully initialized
    # This ensures ApplicationRecord is available
    config.to_prepare do
      require root.join("app", "models", "rails_ui_guard", "feature_status") unless defined?(RailsUiGuard::FeatureStatus)
    end

    # Make view helpers available globally
    initializer "rails_ui_guard.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include RailsUiGuard::ViewHelpers
      end
    end

    # Make controller helpers available and register view helpers
    initializer "rails_ui_guard.controller_helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        include RailsUiGuard::ControllerHelpers
      end
    end

    # Register helpers so they're available in all views
    initializer "rails_ui_guard.register_helpers" do
      ActiveSupport.on_load(:action_controller) do
        helper RailsUiGuard::ViewHelpers
      end
    end
  end
end


