# Load Rails UI Guard gem
# This ensures the gem is loaded early in the Rails boot process
if defined?(Rails)
  require "rails_ui_guard"
end

