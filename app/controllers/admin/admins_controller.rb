# frozen_string_literal: true

class Admin::AdminsController < Admin::BaseController
  before_action :set_admin

  def change_password; end

  def update_password
    if @admin.update_with_password(admin_params)
      flash[:notice] = 'Password successfully updated!'
      sign_in @admin, bypass: true
      redirect_to admin_dashboard_index_path
    else
      Rails.logger.debug("===========#{@admin.errors.full_messages.join(', ')}===========")
      flash[:error] = @admin.errors.full_messages.join(', ')
      redirect_back fallback_location: { action: 'change_password', id: @admin.id }
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:current_password, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find_by_id(params[:admin_id])
    return false if @admin.blank?
  end
end
