# frozen_string_literal: true

module RailsUiGuard
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Creates Rails UI Guard migration and initializer"

      def create_migration
        migration_template(
          "create_rails_ui_guard_feature_statuses.rb.erb",
          "db/migrate/create_rails_ui_guard_feature_statuses.rb"
        )
      end

      def create_initializer
        copy_file "rails_ui_guard.rb", "config/initializers/rails_ui_guard.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end

