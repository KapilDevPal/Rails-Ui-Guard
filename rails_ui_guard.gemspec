# frozen_string_literal: true

require_relative "lib/rails_ui_guard/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_ui_guard"
  spec.version       = RailsUiGuard::VERSION
  spec.authors       = ["Kapil Dev Pal"]
  spec.email         = ["kapildevpal@gmail.com"]

  spec.summary       = "Feature locking and status management system for Rails multi-tenant applications"
  spec.description   = <<~DESC
    Rails UI Guard provides a clean way to lock/unlock features, show maintenance overlays, 
    and enforce backend security for modules in multi-tenant Rails applications.
    
    Features:
    - Per-tenant feature status management (Active, Locked, Under Work)
    - UI blur/overlay system (no JavaScript required)
    - Backend enforcement for security
    - Sidebar status badges
    - Reusable view helpers and partials
    - Rails 6/7/8 compatible
  DESC
  spec.homepage      = "https://github.com/KapilDevPal/Rails-Ui-Guard"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}.git"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "false"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile Rakefile])
    end
  rescue
    # If git is not available, include all files
    Dir.glob("**/*", File::FNM_DOTMATCH).reject do |f|
      File.directory?(f) || 
      f.start_with?("bin/", "test/", "spec/", ".git", "Gemfile", "Rakefile") ||
      f.end_with?(".gem")
    end
  end
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0", "< 9.0"
  spec.add_dependency "activerecord", ">= 6.0", "< 9.0"
end

