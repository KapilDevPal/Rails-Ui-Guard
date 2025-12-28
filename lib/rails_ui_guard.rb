# frozen_string_literal: true

# rails_ui_guard
#
# Feature locking and status management system for Rails multi-tenant applications.
#
# This gem provides:
# - A DB-driven feature-status model (per-tenant)
# - Controller guards (backend enforcement)
# - View helpers + reusable overlay partial (UX blur/lock; no JS)
#
# See README.md for installation and usage instructions.

require "active_support"

# Ensure namespace exists even if files are loaded out-of-order.
module RailsUiGuard
end

# Core pieces (required early so models can safely `include RailsUiGuard::...`)
require_relative "rails_ui_guard/concerns/feature_statusable"
# Note: FeatureStatus model is loaded by the engine via config.to_prepare
# to ensure ApplicationRecord is available

require_relative "rails_ui_guard/version"
require_relative "rails_ui_guard/controller_helpers"
require_relative "rails_ui_guard/view_helpers"

# Engine hooks views/helpers into the host app and configures autoloading
require_relative "rails_ui_guard/engine" if defined?(Rails)

