# frozen_string_literal: true

module RailsUiGuard
  # Controller helpers for enforcing feature/module access (backend security)
  #
  # Pattern:
  #   class FeesController < ApplicationController
  #     before_action -> { rails_ui_guard_set_feature!("Fee Management") }
  #     before_action -> { rails_ui_guard_enforce_active!("Fee Management") }, only: [:create, :update, :destroy]
  #   end
  #
  # Notes:
  # - Read actions can render normally (UX overlay will blur/freeze if locked)
  # - Write actions MUST be blocked server-side to prevent URL/API bypass
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      helper_method :rails_ui_guard_current_school
    end

    # Override by defining `current_school` in ApplicationController (you already have this).
    def rails_ui_guard_current_school
      respond_to?(:current_school) ? current_school : nil
    end

    # Sets instance variables used by the layout overlay:
    # - @feature_key
    # - @module_status  (:active | :locked | :under_work | ...)
    # - @feature_status_record (optional, provides message/help_text)
    def rails_ui_guard_set_feature!(feature_key)
      @feature_key = feature_key.to_s
      school = rails_ui_guard_current_school

      if school&.respond_to?(:module_status)
        @module_status = school.module_status(@feature_key)
        if school.respond_to?(:feature_status_record)
          @feature_status_record = school.feature_status_record(@feature_key)
        end
      else
        @module_status = :active
        @feature_status_record = nil
      end
    end

    # Backend enforcement: blocks non-active access for critical actions.
    #
    # - For HTML: redirect back (or to root) with a clear flash
    # - For JSON: returns 403
    def rails_ui_guard_enforce_active!(feature_key, redirect_to: nil)
      school = rails_ui_guard_current_school
      status = school&.respond_to?(:module_status) ? school.module_status(feature_key) : :active
      return if status.to_sym == :active

      message =
        case status.to_sym
        when :locked
          "This feature is not enabled for your school."
        when :under_work
          "This feature is temporarily unavailable (maintenance/under work)."
        else
          "This feature is currently unavailable."
        end

      respond_to do |format|
        format.html do
          flash[:alert] = message
          target = redirect_to || (request.referer.presence || main_app.root_path)
          redirect_to target
        end
        format.json { render json: { error: message, feature_status: status }, status: :forbidden }
        format.any  { head :forbidden }
      end
    end
  end
end


