# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2024-12-28

### Fixed
- Fixed `root` method error in engine's config.to_prepare block
- Use File.expand_path instead of root.join for better compatibility

## [0.1.2] - 2024-12-28

### Fixed
- Fixed ApplicationRecord loading issue - FeatureStatus model now loads after ApplicationRecord is available
- Removed early require of FeatureStatus model from main gem file
- Model now loads via engine's config.to_prepare block

## [0.1.1] - 2024-12-28

### Enhanced
- Improved overlay UI with better visual design
- Enhanced color-coded headers (red for locked, yellow for under work)
- Better icon display with rounded backgrounds
- Improved message formatting and readability
- Added action buttons (Go to Dashboard, Manage Access for admins)
- Enhanced CSS with animations (fade-in, slide-up)
- Better backdrop blur effects
- More user-friendly default messages
- Improved mobile responsiveness

### Fixed
- Better handling of feature status records
- Improved variable scope in overlay partial

## [0.1.0] - 2024-12-28

### Added
- Initial release of Rails UI Guard
- Feature status management (Active, Locked, Under Work)
- UI blur/overlay system (no JavaScript required)
- Backend enforcement helpers
- Sidebar status badges with icons
- View helpers for rendering overlays
- Controller helpers for enforcing access
- Model concern for feature status management
- Rails Engine integration
- Migration generator
- Active Admin integration support
- Comprehensive documentation

### Features
- Per-tenant feature locking
- Maintenance mode support
- Mobile-safe and accessible UI
- Rails 6/7/8 compatible
- Polymorphic statusable support

[0.1.1]: https://github.com/KapilDevPal/Rails-Ui-Guard/releases/tag/v0.1.1
[0.1.0]: https://github.com/KapilDevPal/Rails-Ui-Guard/releases/tag/v0.1.0

