# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource_or_scope)
    current_user.present? ? user_path(current_user) : admin_dashboard_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    resource_or_scope.to_s == 'user' ? new_user_session_path : new_admin_session_path
  end
end
