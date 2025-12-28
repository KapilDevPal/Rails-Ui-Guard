# frozen_string_literal: true

module RailsUiGuard
  # DB-backed feature status record.
  #
  # This is the source of truth for per-tenant module/sub-module availability.
  #
  # - statusable: typically School (multi-tenant), but polymorphic for extensibility.
  # - feature_key: stable string key for the module/submodule (e.g. "Fee Management" or "fees_module")
  # - status: :active | :locked | :under_work (extensible)
  class FeatureStatus < ::ApplicationRecord
    self.table_name = "rails_ui_guard_feature_statuses"

    belongs_to :statusable, polymorphic: true

    validates :feature_key, presence: true
    validates :status, presence: true
    validates :feature_key, uniqueness: { scope: %i[statusable_type statusable_id] }

    # Keep statuses as strings for easy future expansion without migrations.
    STATUSES = %w[active locked under_work].freeze

    validates :status, inclusion: { in: STATUSES }

    def active?
      status == "active"
    end

    def locked?
      status == "locked"
    end

    def under_work?
      status == "under_work"
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[id statusable_type statusable_id feature_key status message help_text created_at updated_at]
    end

    def self.ransackable_associations(_auth_object = nil)
      %w[statusable]
    end
  end
end


