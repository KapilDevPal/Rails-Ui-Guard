# frozen_string_literal: true

# Concern to add feature status methods to models (e.g., School)
# Provides module_status(feature_key) method that returns :active, :locked, or :under_work
module RailsUiGuard::FeatureStatusable
  extend ActiveSupport::Concern

  # Returns the FeatureStatus record (if present) for a given feature_key.
  # Useful for retrieving message/help_text in the UI overlay.
  def feature_status_record(feature_key)
    feature_key = feature_key.to_s
    feature_statuses.find_by(feature_key: feature_key)
  end

  # Returns the status of a feature/module for this record
  # @param feature_key [String, Symbol] The key identifying the feature/module
  # @return [Symbol] :active, :locked, or :under_work
  def module_status(feature_key)
    feature_key = feature_key.to_s
    
    # Check if there's a feature_status record for this feature
    status_record = feature_status_record(feature_key)
    return status_record.status.to_sym if status_record
    
    # Fallback: Check module_access if it exists (backward compatibility)
    if respond_to?(:module_accesses)
      module_access = module_accesses.joins(:app_module).find_by(app_modules: { name: feature_key })
      if module_access
        return module_access.granted? ? :active : :locked
      end
    end
    
    # Default to active if no status is set
    :active
  end

  # Check if a feature is active
  def feature_active?(feature_key)
    module_status(feature_key) == :active
  end

  # Check if a feature is locked
  def feature_locked?(feature_key)
    module_status(feature_key) == :locked
  end

  # Check if a feature is under work
  def feature_under_work?(feature_key)
    module_status(feature_key) == :under_work
  end

  # Set the status of a feature
  def set_feature_status(feature_key, status, message: nil, help_text: nil)
    status_record = feature_statuses.find_or_initialize_by(feature_key: feature_key.to_s)
    status_record.status = status.to_s
    status_record.message = message if message.present?
    status_record.help_text = help_text if help_text.present?
    status_record.save!
  end

  class_methods do
    # Include this in your model to add feature status support
    # Requires has_many :feature_statuses association
    def has_feature_status
      has_many :feature_statuses, 
               class_name: 'RailsUiGuard::FeatureStatus',
               dependent: :destroy,
               as: :statusable
    end
  end
end

