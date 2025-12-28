# Rails UI Guard

[![Gem Version](https://badge.fury.io/rb/rails_ui_guard.svg)](https://badge.fury.io/rb/rails_ui_guard)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Feature locking and status management system for Rails multi-tenant applications.

Rails UI Guard provides a clean way to lock/unlock features, show maintenance overlays, and enforce backend security for modules in multi-tenant Rails applications.

## Features

- ✅ **Per-tenant feature status management** (Active, Locked, Under Work)
- ✅ **UI blur/overlay system** (no JavaScript required)
- ✅ **Backend enforcement** for security
- ✅ **Sidebar status badges** with icons
- ✅ **Reusable view helpers and partials**
- ✅ **Rails 6/7/8 compatible**
- ✅ **Mobile-safe and accessible**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_ui_guard', git: 'https://github.com/KapilDevPal/Rails-Ui-Guard.git'
```

Or if published to RubyGems:

```ruby
gem 'rails_ui_guard'
```

Then execute:

```bash
$ bundle install
```

Run the generator to create the migration and initializer:

```bash
$ rails generate rails_ui_guard:install
$ rails db:migrate
```

## Quick Start

### 1. Include in your model (e.g., School)

```ruby
class School < ApplicationRecord
  include RailsUiGuard::FeatureStatusable
  has_feature_status
end
```

### 2. Include in ApplicationController

```ruby
class ApplicationController < ActionController::Base
  include RailsUiGuard::ControllerHelpers
end
```

### 3. Use in your controllers

```ruby
class FeesController < ApplicationController
  before_action :set_current_school
  before_action -> { enforce_feature_access("fee_management") }
  
  def index
    @module_status = current_school.module_status("fee_management")
    # ... rest of action
  end
end
```

### 4. Add to your layout

```erb
<!-- app/views/layouts/application.html.erb -->
<%= render_module_overlay(@module_status) %>
```

### 5. Add status badges to sidebar (optional)

```erb
<!-- app/views/shared/_sidebar.html.erb -->
<% feature_key = app_module.name.parameterize(separator: '_') %>
<% module_status = current_school.module_status(feature_key) %>
<%= rails_ui_guard_status_badge(module_status) %>
```

## Feature States

### Active (`:active`)
- Module is fully accessible and functional
- No restrictions or overlays

### Locked (`:locked`)
- Module is not enabled for this tenant
- Page content is blurred with lock overlay
- All interactions blocked
- Backend actions are blocked

### Under Work (`:under_work`)
- Module is temporarily unavailable (maintenance)
- Page content is blurred with maintenance overlay
- All interactions blocked
- Backend actions are blocked

## Usage Examples

### Setting Feature Status

```ruby
# In Rails console or admin panel
school = School.find_by(name: "Demo School")

# Lock a feature
school.set_feature_status("fee_management", :locked, 
  message: "Fee Management is not available in your plan.",
  help_text: "Contact sales@example.com to upgrade.")

# Set to under work
school.set_feature_status("fee_management", :under_work,
  message: "Fee Management is under maintenance. Expected completion: 2:00 PM.")

# Set to active
school.set_feature_status("fee_management", :active)
```

### Checking Feature Status

```ruby
school.module_status("fee_management")  # => :active, :locked, or :under_work
school.feature_active?("fee_management")  # => true/false
school.feature_locked?("fee_management")  # => true/false
school.feature_under_work?("fee_management")  # => true/false
```

### Controller Helpers

```ruby
# Set feature status (for overlay display)
rails_ui_guard_set_feature!("fee_management")

# Enforce active status (blocks non-active)
rails_ui_guard_enforce_active!("fee_management")
```

### View Helpers

```erb
<!-- Status badge -->
<%= rails_ui_guard_status_badge(module_status) %>

<!-- Wrap content with blur/overlay -->
<%= rails_ui_guard_wrap(status: @module_status, feature_key: "fee_management") do %>
  <!-- Content here -->
<% end %>

<!-- Render overlay -->
<%= render_module_overlay(@module_status) %>
```

## Active Admin Integration

The gem includes an Active Admin resource for managing feature statuses. To use it, create:

```ruby
# app/admin/feature_statuses.rb
ActiveAdmin.register RailsUiGuard::FeatureStatus, as: "FeatureStatus" do
  menu label: "Module Lock & Status", priority: 5
  
  permit_params :statusable_type, :statusable_id, :feature_key, :status, :message, :help_text
  
  # ... rest of configuration
end
```

See the [full documentation](https://github.com/KapilDevPal/Rails-Ui-Guard) for complete Active Admin setup.

## Security

⚠️ **Important**: The UI blur/overlay is **UX only**. Backend enforcement is **mandatory** and cannot be bypassed by disabling JavaScript or manipulating the DOM.

Always use `enforce_feature_access` in your controllers:

```ruby
before_action -> { enforce_feature_access("fee_management") }
```

## Requirements

- Ruby >= 2.7.0
- Rails >= 6.0, < 9.0
- ActiveRecord >= 6.0, < 9.0

## Development

After checking out the repo, run:

```bash
$ bundle install
$ rake test
```

To build and install the gem:

```bash
$ gem build rails_ui_guard.gemspec
$ gem install rails_ui_guard-0.1.0.gem
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/KapilDevPal/Rails-Ui-Guard.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Author

**Kapil Dev Pal**

- GitHub: [@KapilDevPal](https://github.com/KapilDevPal)
- Email: kapildevpal@gmail.com

## Support

For questions or issues:
1. Check the [documentation](https://github.com/KapilDevPal/Rails-Ui-Guard)
2. Open an [issue](https://github.com/KapilDevPal/Rails-Ui-Guard/issues)
3. Contact the maintainer

---

Made with ❤️ for the Rails community

